import { Gtk } from "ags/gtk3";

export default function () {
  return (
    <box class={"calendar"}>
      <Gtk.Calendar hexpand />
    </box>
  );
}
