import app from "ags/gtk3/app";
import { Astal, Gdk, Gtk } from "ags/gtk3";
import { execAsync } from "ags/process";
import { Accessor, createState, Setter } from "ags";
import {
  DEFAULT_MARGIN,
  getGlobalSetting,
  globalFontSize,
  globalIconSize,
  globalOpacity,
  globalScale,
  globalSettings,
  setGlobalFontSize,
  setGlobalIconSize,
  setGlobalOpacity,
  setGlobalScale,
  setGlobalSetting,
} from "../variables";
import { AdjustableSetting, processNestedSettings } from "../utils/settings";

function InnerCategory(title: string) {
  return <label label={title} />;
}

function normalizeValue(value: number, type: string) {
  switch (type) {
    case "int":
      return Math.round(value);
    case "float":
      return Math.round(value * 100) / 100;
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
      <box class={"window-actions"} hexpand>
        <box halign={Gtk.Align.START} hexpand>
          <button
            halign={Gtk.Align.END}
            label={""}
            onClicked={() =>
              app.get_window(`settings_${monitorIdentifier}`)?.hide()
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
        hyprlandSettings.push(InnerCategory(k) as Gtk.Widget);
      },
      (p, k, v) => {
        hyprlandSettings.push(createSettingWidget(p) as Gtk.Widget);
      },
      () => {},
    );

    return (
      <scrollable heightRequest={500}>
        <box class={"settings"} spacing={5} vertical>
          <label class={"category"} label={"AGS"} />
          {createSettingWidget(globalOpacity, setGlobalOpacity)}
          {createSettingWidget(globalIconSize, setGlobalIconSize)}
          {createSettingWidget(globalScale, setGlobalScale)}
          {createSettingWidget(globalFontSize, setGlobalFontSize)}
          <label class={"category"} label={"Hyprland"} />
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
      application={app}
      anchor={Astal.WindowAnchor.BOTTOM | Astal.WindowAnchor.LEFT}
      visible={false}
      margin={DEFAULT_MARGIN}
    >
      <box class={"settings-widget"} vertical>
        <WindowActions />
        <Settings />
      </box>
    </window>
  );
}

function createSettingWidget(
  setting: Accessor<AdjustableSetting> | string,
  setter?: Setter<AdjustableSetting>,
) {
  let settingAccess: Accessor<AdjustableSetting>;
  let settingSetter: Setter<AdjustableSetting>;

  if (typeof setting === "string") {
    const [state, setState] = createState(getGlobalSetting(setting));
    settingAccess = state;
    settingSetter = setState;
    settingAccess.subscribe(() =>
      setGlobalSetting(setting, settingAccess.get()),
    );
  } else if (setter) {
    settingAccess = setting;
    settingSetter = setter;
  } else {
    throw new Error("Setter not set when using accessor for setting widget");
  }

  const settingValue = settingAccess.get();

  const sliderWidget = (
    <box halign={Gtk.Align.END} spacing={5} hexpand>
      <slider
        class={"slider"}
        halign={Gtk.Align.END}
        step={1}
        widthRequest={169}
        value={settingValue.value}
        min={settingValue.min}
        max={settingValue.max}
        onDragged={({ value }) => {
          settingSetter({
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
          settingSetter({
            ...settingValue,
            value: active,
          });
        }}
      />
    </box>
  );

  return (
    <box class={"setting"} spacing={5} hexpand>
      <label halign={Gtk.Align.START} label={settingValue.name} />
      {settingValue.type === "bool" ? switchWidget : sliderWidget}
    </box>
  );
}
