import { App, Astal, Gdk, Gtk } from "astal/gtk3";
import { DEFAULT_MARGIN, globalIconSize, globalOpacity } from "../variables";
import { execAsync, Variable } from "astal";
import { AGSSetting } from "../utils/settings";

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
    return (
      <scrollable heightRequest={500}>
        <box className={"settings"} spacing={5} vertical>
          <label className={"category"} label={"AGS"} />
          {agsSetting(globalOpacity)}
          {agsSetting(globalIconSize)}
        </box>
      </scrollable>
    );
  }

  return (
    <window
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

function agsSetting(setting: Variable<AGSSetting>) {
  const settingValue = setting.get();

  const sliderWidget = (
    <box halign={Gtk.Align.END} spacing={5} hexpand>
      <slider
        className={"slider"}
        halign={Gtk.Align.END}
        step={1}
        widthRequest={169}
        value={settingValue.value / (settingValue.max - settingValue.min)}
        onDragged={({ value }) => {
          setting.set({
            ...settingValue,
            value: normalizeValue(
              value * (settingValue.max - settingValue.min),
              settingValue.type,
            ),
          });
        }}
      />
      {/* <label */}
      {/*   xalign={1} */}
      {/*   hexpand */}
      {/*   label={bind(setting).as( */}
      {/*     (s) => `${Math.round((s.value / (s.max - s.min)) * 100)}`, */}
      {/*   )} */}
      {/* /> */}
    </box>
  );

  const switchWidget = (
    <box halign={Gtk.Align.END} spacing={5} hexpand>
      <switch
        active={settingValue.value}
        onButtonPressEvent={({ active }) => {
          active = !active;
          setting.set({
            ...settingValue,
            value: active,
          });
        }}
      />
      {/* <label */}
      {/*   xalign={1} */}
      {/*   hexpand */}
      {/*   label={bind(setting).as((s) => (s.value ? "On" : "Off"))} */}
      {/* /> */}
    </box>
  );

  return (
    <box className={"setting"} spacing={5} hexpand>
      <label halign={Gtk.Align.START} label={settingValue.name} />
      {settingValue.type === "bool" ? switchWidget : sliderWidget}
    </box>
  );
}

function normalizeValue(value: number, type: string) {
  switch (type) {
    case "int":
      return Math.round(value);
    case "float":
      return value.toFixed(2);
  }
}
