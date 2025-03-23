import { App, Astal, Gdk, Gtk } from "astal/gtk3";
import { bind, Variable } from "astal";
import { Subscribable } from "astal/binding";
import { DEFAULT_MARGIN, dnd } from "../variables";
import Notification from "./Notification";
import Notifd from "gi://AstalNotifd";

export default function NotificationPopups(
  gdkMonitor: Gdk.Monitor,
  monitorIdentifier: string,
) {
  const notifications = new NotificationMap();
  return (
    <window
      gdkmonitor={gdkMonitor}
      name={`notification_popups_${monitorIdentifier}`}
      application={App}
      className={"notification-popups"}
      exclusivity={Astal.Exclusivity.EXCLUSIVE}
      layer={Astal.Layer.OVERLAY}
      anchor={Astal.WindowAnchor.TOP | Astal.WindowAnchor.RIGHT}
      margin={DEFAULT_MARGIN}
      widthRequest={400}
    >
      <box spacing={DEFAULT_MARGIN} vertical vexpand>
        {bind(notifications)}
      </box>
    </window>
  );
}

// The purpose if this class is to replace Variable<Array<Widget>>
// with a Map<number, Widget> type in order to track notification widgets
// by their id, while making it conveniently bindable as an array
class NotificationMap implements Subscribable {
  // the underlying notificationMap to keep track of id widget pairs
  private notificationMap: Map<number, Gtk.Widget> = new Map();

  // it makes sense to use a Variable under the hood and use its
  // reactivity implementation instead of keeping track of subscribers ourselves
  private notifications: Variable<Array<Gtk.Widget>> = Variable([]);

  // notify subscribers to re-render when state changes
  private notify() {
    this.notifications.set([...this.notificationMap.values()].reverse());
  }

  constructor() {
    const notifd = Notifd.get_default();

    /**
     * uncomment this if you want to
     * ignore timeout by senders and enforce our own timeout
     * note that if the notification has any actions
     * they might not work, since the sender already treats them as resolved
     */
    // notifd.ignoreTimeout = true

    notifd.connect("notified", (_, id) => {
      if (dnd.get()) return;
      this.set(
        id,
        Notification({
          notification: notifd.get_notification(id)!,
          popup: true,
        }),
      );
    });

    // notifications can be closed by the outside before
    // any user input, which have to be handled too
    notifd.connect("resolved", (_, id) => {
      this.delete(id);
    });
  }

  private set(key: number, value: Gtk.Widget) {
    // in case of replacecment hide previous widget
    this.notificationMap.get(key)?.hide();
    this.notificationMap.set(key, value);
    this.notify();
  }

  private delete(key: number) {
    this.notificationMap.get(key)?.hide();
    this.notificationMap.delete(key);
    this.notify();
  }

  // needed by the Subscribable interface
  get() {
    return this.notifications.get();
  }

  // needed by the Subscribable interface
  subscribe(callback: (list: Array<Gtk.Widget>) => void) {
    return this.notifications.subscribe(callback);
  }
}
