import { bind, execAsync } from "astal";
import { Gtk } from "astal/gtk3";
import Wp from "gi://AstalWp";
import Tray from "gi://AstalTray";
import CustomRevealer from "./CustomRevealer";
import ToggleButton from "./ToggleButton";
import {
  barLock,
  barOrientation,
  dnd,
  rightPanelLock,
  rightPanelVisibility,
  TRANSITION_DURATION,
} from "../../../variables";

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

  function PinBar() {
    return (
      <ToggleButton
        state={barLock.get()}
        onToggled={(self, on) => {
          barLock.set(on);
          self.label = on ? "" : "";
        }}
        className={"icon"}
        label={barLock.get() ? "" : ""}
      />
    );
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
        onClicked={() => barOrientation.set(!barOrientation.get())}
        className={"icon"}
        label={bind(barOrientation).as((orientation) =>
          orientation ? "" : "",
        )}
      />
    );
  }

  function RightPanel() {
    return (
      <revealer
        revealChild={bind(rightPanelLock).as((lock) => lock)}
        transitionType={Gtk.RevealerTransitionType.SLIDE_LEFT}
        transitionDuration={TRANSITION_DURATION}
        child={
          <ToggleButton
            state={bind(rightPanelVisibility)}
            label={bind(rightPanelVisibility).as((v) => (v ? "" : ""))}
            onToggled={(_, on) => rightPanelVisibility.set(on)}
            className={"icon"}
          />
        }
      />
    );
  }

  return (
    <box className={"bar-right"} spacing={5} halign={Gtk.Align.END} hexpand>
      <Volume />
      <SysTray />
      <PinBar />
      <DndToggle />
      <BarOrientationToggle />
      <RightPanel />
    </box>
  );
}
