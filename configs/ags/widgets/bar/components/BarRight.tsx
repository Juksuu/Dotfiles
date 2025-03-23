import { bind, execAsync } from "astal";
import { Gtk } from "astal/gtk3";
import Wp from "gi://AstalWp";
import Tray from "gi://AstalTray";
import CustomRevealer from "./CustomRevealer";
import { barPosition, dnd } from "../../../variables";
import { BarPosition } from "../../../utils/settings";
import ToggleButton from "../../ToggleButton";

export default function BarRight() {
  function Volume() {
    const wp = Wp.get_default();
    const speaker = wp?.audio.defaultSpeaker!;

    const icon = <icon className={"icon"} icon={bind(speaker, "volumeIcon")} />;

    const slider = (
      <slider
        className={"slider"}
        step={0.1}
        widthRequest={100}
        onDragged={({ value }) => (speaker.volume = value)}
        value={bind(speaker, "volume")}
      />
    );

    return CustomRevealer(icon, slider, "", () => execAsync("pavucontrol"));
  }

  function SysTray() {
    const tray = Tray.get_default();

    const items = bind(tray, "items").as((items) =>
      items.map((item) => {
        return (
          <menubutton
            margin={0}
            usePopover={false}
            cursor={"pointer"}
            tooltipMarkup={bind(item, "tooltipMarkup")}
            actionGroup={bind(item, "actionGroup").as((ag) => ["dbusmenu", ag])}
            menuModel={bind(item, "menuModel")}
          >
            <icon gicon={bind(item, "gicon")} />
          </menubutton>
        );
      }),
    );

    return <box className={"system-tray"}>{items}</box>;
  }

  function DndToggle() {
    return (
      <ToggleButton
        state={dnd.get()}
        onToggled={(self, on) => {
          dnd.set(on);
          self.label = dnd.get() ? "" : "";
        }}
        className={"icon"}
        label={dnd.get() ? "" : ""}
      />
    );
  }

  function BarOrientationToggle() {
    return (
      <button
        onClicked={() =>
          barPosition.set(
            barPosition.get() === BarPosition.Top
              ? BarPosition.Bottom
              : BarPosition.Top,
          )
        }
        className={"icon"}
        label={bind(barPosition).as((position) =>
          position === BarPosition.Top ? "" : "",
        )}
      />
    );
  }

  return (
    <box className={"bar-right"} spacing={5} halign={Gtk.Align.END} hexpand>
      <Volume />
      <SysTray />
      <DndToggle />
      <BarOrientationToggle />
    </box>
  );
}
