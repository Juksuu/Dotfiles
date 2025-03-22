import { GLib } from "astal";

export function asyncSleep(duration: number) {
  return new Promise((resolve) => setTimeout(resolve, duration));
}

export function time(time: number, format = "%H:%M") {
  return GLib.DateTime.new_from_unix_local(time).format(format)!;
}
