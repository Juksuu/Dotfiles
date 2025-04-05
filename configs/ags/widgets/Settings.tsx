import { App, Astal, Gdk, Gtk } from "astal/gtk3";
import {
  DEFAULT_MARGIN,
  getGlobalSetting,
  globalFontSize,
  globalIconSize,
  globalOpacity,
  globalScale,
  globalSettings,
  setGlobalSetting,
} from "../variables";
import { execAsync, Variable } from "astal";
import { AdjustableSetting, processNestedSettings } from "../utils/settings";

function InnerCategory(title: string) {
  return <label label={title} />;
}

function normalizeValue(value: number, type: string) {
  switch (type) {
    case "int":
      return Math.round(value);
    case "float":
      return value.toFixed(2);
    default:
      throw new Error(`No normalize method implemented for type: ${type}`);
  }
}

export default function Settings(
  gdkmonitor: Gdk.Monitor,
  monitorIdentifier: string,
) {
  function WindowActions() {
    return (
      <box className={"window-actions"} hexpand>
        <box halign={Gtk.Align.START} hexpand>
          <button
            halign={Gtk.Align.END}
            label={""}
            onClicked={() =>
              App.get_window(`settings_${monitorIdentifier}`)?.hide()
            }
          />
        </box>
        <button
          label={"󰑐"}
          onClicked={() => execAsync(`bash -c "hyprctl reload"`)}
        />
      </box>
    );
  }

  function Settings() {
    const hyprlandSettings: Gtk.Widget[] = [];

    processNestedSettings(
      globalSettings.get().hyprland,
      "hyprland",
      (p, k) => {
        hyprlandSettings.push(InnerCategory(k));
      },
      (p, k, v) => {
        hyprlandSettings.push(createSettingWidget(p));
      },
      () => {},
    );

    return (
      <scrollable heightRequest={500}>
        <box className={"settings"} spacing={5} vertical>
          <label className={"category"} label={"AGS"} />
          {createSettingWidget(globalOpacity)}
          {createSettingWidget(globalIconSize)}
          {createSettingWidget(globalScale)}
          {createSettingWidget(globalFontSize)}
          <label className={"category"} label={"Hyprland"} />
          {hyprlandSettings}
        </box>
      </scrollable>
    );
  }

  return (
    <window
      namespace={"settings"}
      gdkmonitor={gdkmonitor}
      name={`settings_${monitorIdentifier}`}
      application={App}
      anchor={Astal.WindowAnchor.BOTTOM | Astal.WindowAnchor.LEFT}
      visible={false}
      margin={DEFAULT_MARGIN}
    >
      <box className={"settings-widget"} vertical>
        <WindowActions />
        <Settings />
      </box>
    </window>
  );
}

function createSettingWidget(setting: Variable<AdjustableSetting> | string) {
  let settingVar: Variable<AdjustableSetting>;

  if (typeof setting === "string") {
    settingVar = Variable(getGlobalSetting(setting));
    settingVar.subscribe((v) => setGlobalSetting(setting, v));
  } else {
    settingVar = setting;
  }

  const settingValue = settingVar.get();

  const sliderWidget = (
    <box halign={Gtk.Align.END} spacing={5} hexpand>
      <slider
        className={"slider"}
        halign={Gtk.Align.END}
        step={1}
        widthRequest={169}
        value={settingValue.value}
        min={settingValue.min}
        max={settingValue.max}
        onDragged={({ value }) => {
          settingVar.set({
            ...settingValue,
            value: normalizeValue(value, settingValue.type),
          });
        }}
      />
    </box>
  );

  const switchWidget = (
    <box halign={Gtk.Align.END} spacing={5} hexpand>
      <switch
        active={settingValue.value}
        onButtonPressEvent={({ active }) => {
          active = !active;
          settingVar.set({
            ...settingValue,
            value: active,
          });
        }}
      />
    </box>
  );

  return (
    <box className={"setting"} spacing={5} hexpand>
      <label halign={Gtk.Align.START} label={settingValue.name} />
      {settingValue.type === "bool" ? switchWidget : sliderWidget}
    </box>
  );
}
