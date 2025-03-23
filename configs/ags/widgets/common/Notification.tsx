import { bind, execAsync, timeout, Variable } from "astal";
import { NOTIFICATION_DELAY, TRANSITION_DURATION } from "../../variables";
import Notifd from "gi://AstalNotifd";
import { Astal, Gtk } from "astal/gtk3";
import ToggleButton from "./ToggleButton";
import { Revealer } from "astal/gtk3/widget";
import { time, timerWithCallback } from "../../utils/time";

const TRANSITION = 200;

type Props = {
  notification: Notifd.Notification;
  newNotification?: boolean;
  popup?: boolean;
};

export default function Notification({
  notification,
  newNotification,
  popup,
}: Props) {
  function closeNotification() {
    timeout(TRANSITION_DURATION - 300, () => {
      if (popup) {
        Parent.destroy();
      }
    });
  }

  const isLocked = Variable(false);
  isLocked.subscribe((v) => {
    if (!v) {
      timeout(NOTIFICATION_DELAY, () => {
        if (!isLocked.get() && popup) closeNotification();
      });
    }
  });

  const LockButton = (
    <ToggleButton
      className={"lock"}
      label={""}
      onToggled={(self, on) => {
        isLocked.set(on);
      }}
    />
  );

  const CopyButton = (
    <button
      className={"copy"}
      label={""}
      onClicked={() => {
        execAsync(`wl-copy ${notification.body}`).catch((err) =>
          print(`Notification copy error: ${err}`),
        );
      }}
    ></button>
  );

  const LeftRevealer = (
    <revealer
      transitionType={Gtk.RevealerTransitionType.SLIDE_LEFT}
      transitionDuration={TRANSITION_DURATION}
      revealChild={false}
    >
      {popup ? LockButton : CopyButton}
    </revealer>
  );

  const NotificationTimer = () => {
    const timer = Variable(NOTIFICATION_DELAY);
    timerWithCallback(timer.get(), 50, (v) => timer.set(v));

    return (
      <circularprogress
        className={"circular-progress"}
        rounded
        value={bind(timer).as((t) => t / NOTIFICATION_DELAY)}
      />
    );
  };

  const Title = (
    <label
      className={"title"}
      xalign={0}
      justify={Gtk.Justification.LEFT}
      maxWidthChars={24}
      label={notification.summary}
      hexpand
      truncate
      wrap
      useMarkup
    />
  );

  const Body = (
    <label
      className={"body"}
      xalign={0}
      justify={Gtk.Justification.LEFT}
      maxWidthChars={24}
      label={notification.body}
      hexpand
      truncate
      wrap
    />
  );

  const Expand = (
    <ToggleButton
      className={"expand"}
      label={""}
      onToggled={(self, on) => {
        Title.set_property("truncate", !on);
        Body.set_property("truncate", !on);
        self.label = on ? "" : "";
      }}
    />
  );

  const CloseRevealer = (
    <revealer
      transitionType={Gtk.RevealerTransitionType.SLIDE_RIGHT}
      transitionDuration={TRANSITION_DURATION}
    >
      <button
        className={"close"}
        label={""}
        onClicked={() => {
          closeNotification();
          notification.dismiss();
        }}
      />
    </revealer>
  );

  const TopBar = (
    <box className={"top-bar"} spacing={5} hexpand>
      {LeftRevealer}
      {popup ? <NotificationTimer /> : <box />}
      <label
        className={"app-name"}
        xalign={0}
        truncate={popup}
        label={notification.appName}
        hexpand
        wrap
      />
      <label
        className={"time"}
        xalign={1}
        label={time(notification.time)}
        hexpand
      />
      {Expand}
      {CloseRevealer}
    </box>
  );

  const Icon = (
    <box className={"icon"} valign={Gtk.Align.START} halign={Gtk.Align.CENTER}>
      {notificationIcon(notification)}
    </box>
  );

  const Content = (
    <box
      className={`notification ${notification.urgency} ${notification.appName}`}
    >
      <box className={"main-content"} spacing={10} vertical>
        {TopBar}
        <box spacing={5}>
          {Icon}
          <box spacing={5} vertical>
            <box hexpand>{Title}</box>
            {Body}
          </box>
        </box>
      </box>
    </box>
  );

  const Revealer = (
    <revealer
      transitionType={Gtk.RevealerTransitionType.SLIDE_DOWN}
      transitionDuration={TRANSITION}
      revealChild={!newNotification}
    >
      {Content}
    </revealer>
  );

  const Parent = (
    <box
      setup={(self) => {
        timeout(NOTIFICATION_DELAY, () => {
          if (!isLocked.get() && popup) closeNotification();
        });
      }}
    >
      <eventbox
        onHover={() => {
          (LeftRevealer as Revealer).revealChild = true;
          (CloseRevealer as Revealer).revealChild = true;
        }}
        onHoverLost={() => {
          if (!isLocked.get()) (LeftRevealer as Revealer).revealChild = false;
          (CloseRevealer as Revealer).revealChild = false;
        }}
        onClick={() => {
          popup ? LockButton.activate() : CopyButton.activate();
        }}
      >
        {Revealer}
      </eventbox>
    </box>
  );

  return Parent;
}

function notificationIcon(notification: Notifd.Notification) {
  const isIcon = (icon: string) => !!Astal.Icon.lookup_icon(icon);

  if (notification.image) {
    return (
      <box
        className={"image"}
        css={`
          background-image: url("${notification.image}");
          background-size: cover;
          background-repeat: no-repeat;
          background-position: center;
          border-radius: 10px;
        `}
      />
    );
  }

  let icon = "dialog-information";
  if (isIcon(notification.appIcon)) icon = notification.appIcon;

  if (notification.desktopEntry && isIcon(notification.desktopEntry))
    icon = notification.desktopEntry;

  return <icon className={"icon"} icon={icon} />;
}
