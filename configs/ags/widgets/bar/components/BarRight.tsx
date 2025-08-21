import Tray from "gi://AstalTray";
import { Gtk } from "ags/gtk3";
import { createBinding, For } from "ags";
import { barPosition, dnd, setBarPosition, setDnd } from "../../../variables";
import { BarPosition } from "../../../utils/settings";

export default function BarRight() {
  function SysTray() {
    const tray = Tray.get_default();

    const items = createBinding(tray, "items").as((items) =>
      items.map((item) => {
        return (
          <menubutton
            margin={0}
            usePopover={false}
            tooltipMarkup={createBinding(item, "tooltipMarkup")}
            menuModel={createBinding(item, "menuModel")}
            $={(self) => {
              self.insert_action_group("dbusmenu", item.actionGroup);
            }}
          >
            <icon gicon={createBinding(item, "gicon")} />
          </menubutton>
        );
      }),
    );

    const visible = items.as((i) => i.length > 0);

    return (
      <box class={"system-tray"} visible={visible}>
        <For each={items}>{(item) => item}</For>
      </box>
    );
  }

  function DndToggle() {
    return (
      <Gtk.ToggleButton
        active={dnd.get()}
        onToggled={(self) => {
          setDnd(self.active);
          self.label = dnd.get() ? "" : "";
        }}
        class={"icon"}
        label={dnd.get() ? "" : ""}
      />
    );
  }

  function BarOrientationToggle() {
    return (
      <button
        onClicked={() =>
          setBarPosition(
            barPosition.get() === BarPosition.Top
              ? BarPosition.Bottom
              : BarPosition.Top,
          )
        }
        class={"icon"}
        label={barPosition.as((position) =>
          position === BarPosition.Top ? "" : "",
        )}
      />
    );
  }

  return (
    <box class={"bar-right"} spacing={5} halign={Gtk.Align.END} hexpand>
      <SysTray />
      <DndToggle />
      <BarOrientationToggle />
    </box>
  );
}
