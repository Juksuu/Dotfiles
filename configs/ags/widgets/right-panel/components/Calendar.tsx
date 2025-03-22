import { astalify, Gtk, type ConstructProps } from "astal/gtk3";
import GObject from "gi://GObject?version=2.0";

type CalendarProps = ConstructProps<
  Gtk.Calendar,
  Gtk.Calendar.ConstructorProps
>;
class Calendar extends astalify(Gtk.Calendar) {
  static {
    GObject.registerClass(this);
  }
  constructor(props: CalendarProps) {
    super(props as any);
  }
}

export default function () {
  return (
    <box className={"calendar"}>
      <Calendar hexpand />
    </box>
  );
}
