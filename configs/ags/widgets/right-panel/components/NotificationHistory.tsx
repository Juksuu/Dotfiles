import { Variable, bind } from "astal";
import { Gtk } from "astal/gtk3";
import Notification from "../../common/Notification";
import Notifd from "gi://AstalNotifd";

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

  const notificationFilter = Variable<Filter>({ name: "", class: "" });

  function Filter() {
    return (
      <box className={"filter"} hexpand>
        {FILTERS.map((filter) => {
          <button
            className={bind(notificationFilter).as((f) =>
              f.class === filter.class ? "active" : "",
            )}
            onClicked={() => {
              notificationFilter.set(
                notificationFilter.get() === filter
                  ? { name: "", class: "" }
                  : filter,
              );
            }}
            hexpand
            label={filter.name}
          ></button>;
        })}
      </box>
    );
  }

  function History() {
    const notifications = Variable.derive(
      [bind(notifd, "notifications"), notificationFilter],
      (notifs, filter) => {
        if (!notifs) return [];
        return filterNotifications(notifs, filter.name).map((notification) => (
          <Notification notification={notification} />
        ));
      },
    );

    return (
      <box spacing={5} vertical>
        {bind(notifications)}
      </box>
    );
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
        className={"clear"}
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
    <box className={"notification-history"} spacing={5} vertical>
      <Filter />
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
