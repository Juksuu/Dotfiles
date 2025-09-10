import Notification from "../../Notification";
import Notifd from "gi://AstalNotifd";
import { Gtk } from "ags/gtk3";
import { createBinding, createComputed, createState, For } from "ags";

type Filter = {
  name: string;
  class: string;
};

const FILTERS: Filter[] = [
  { name: "Spotify", class: "spotify" },
  { name: "Clipboard", class: "clipboard" },
];

const MAX_NOTIFICATIONS = 10;

export default function NotificationHistory() {
  const notifd = Notifd.get_default();

  const [notificationFilter, setNotificationFilter] = createState<Filter>({
    name: "",
    class: "",
  });

  function FilterDisplay() {
    return (
      <box class={"filter"} hexpand>
        {FILTERS.map((filter) => {
          return (
            <button
              class={notificationFilter.as((f) => {
                return f.class === filter.class ? filter.class : "";
              })}
              onClicked={() => {
                const data =
                  notificationFilter.get().class === filter.class
                    ? { name: "", class: "" }
                    : filter;

                setNotificationFilter(data);
              }}
              hexpand
              label={filter.name}
            ></button>
          );
        })}
      </box>
    );
  }

  function History() {
    const notifications = createComputed(
      [createBinding(notifd, "notifications"), notificationFilter],
      (notifs, filter) => {
        if (!notifs) return [];
        return filterNotifications(notifs, filter.name).map((notification) => (
          <Notification notification={notification} />
        ));
      },
    );

    const box = (<box spacing={5} vertical></box>) as Gtk.Box;

    function updateNotifs() {
      for (const child of box.get_children()) {
        box.remove(child);
      }
      for (const notif of notifications.get()) {
        box.add(notif as Gtk.Widget);
      }
    }
    notifications.subscribe(() => updateNotifs());
    updateNotifs();

    return box;
  }

  function NotificationsDisplay() {
    return (
      <scrollable
        hscroll={Gtk.PolicyType.NEVER}
        vscroll={Gtk.PolicyType.AUTOMATIC}
        vexpand
      >
        <History />
      </scrollable>
    );
  }

  function ClearNotifications() {
    return (
      <button
        class={"clear"}
        label={""}
        onClicked={() => {
          for (const notification of notifd.notifications) {
            notification.dismiss();
          }
        }}
      ></button>
    );
  }

  return (
    <box class={"notification-history"} spacing={5} vertical>
      <FilterDisplay />
      <NotificationsDisplay />
      <ClearNotifications />
    </box>
  );
}

function filterNotifications(
  notifications: Notifd.Notification[],
  filter: string,
): Notifd.Notification[] {
  const sortedNotifications = notifications.sort((a, b) => b.time - a.time);

  const filtered = [];
  const others = [];

  for (const notification of sortedNotifications) {
    if (
      notification.appName.includes(filter) ||
      notification.summary.includes(filter)
    ) {
      filtered.push(notification);
    } else {
      others.push(notification);
    }
  }

  const combinedNotifications = [...filtered, ...others];
  const keptNotifications = combinedNotifications.splice(0, MAX_NOTIFICATIONS);

  for (const notification of combinedNotifications) {
    notification.dismiss();
  }

  return keptNotifications;
}
