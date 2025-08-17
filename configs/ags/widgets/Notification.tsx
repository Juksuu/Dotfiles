import Notifd from "gi://AstalNotifd";
import { Astal, Gtk } from "ags/gtk3";
import { execAsync } from "ags/process";
import { timeout } from "ags/time";
import { NOTIFICATION_DELAY, TRANSITION_DURATION } from "../variables";
import { time, timerWithCallback } from "../utils/time";
import { createState } from "ags";

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
        (Parent as Gtk.Widget).hide();
      }
    });
  }

  const [isLocked, setIsLocked] = createState(false);
  isLocked.subscribe(() => {
    if (!isLocked.get()) {
      timeout(NOTIFICATION_DELAY, () => {
        if (!isLocked.get() && popup) closeNotification();
      });
    }
  });

  const LockButton = (
    <Gtk.ToggleButton
      class={"lock"}
      label={""}
      onToggled={({ active }) => {
        setIsLocked(active);
      }}
    />
  );

  const CopyButton = (
    <button
      class={"copy"}
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
    const [timer, setTimer] = createState(NOTIFICATION_DELAY);
    timerWithCallback(timer.get(), 50, (v) => setTimer(v));

    return (
      <circularprogress
        class={"circular-progress"}
        rounded
        value={timer.as((t) => t / NOTIFICATION_DELAY)}
      />
    );
  };

  const Title = (
    <label
      class={"title"}
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
      class={"body"}
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
    <Gtk.ToggleButton
      class={"expand"}
      label={""}
      onToggled={(self) => {
        Title.set_property("truncate", !self.active);
        Body.set_property("truncate", !self.active);
        self.label = self.active ? "" : "";
      }}
    />
  );

  const CloseRevealer = (
    <revealer
      transitionType={Gtk.RevealerTransitionType.SLIDE_RIGHT}
      transitionDuration={TRANSITION_DURATION}
    >
      <button
        class={"close"}
        label={""}
        onClicked={() => {
          closeNotification();
          notification.dismiss();
        }}
      />
    </revealer>
  );

  const TopBar = (
    <box class={"top-bar"} spacing={5} hexpand>
      {LeftRevealer}
      {popup ? <NotificationTimer /> : <box />}
      <label
        class={"app-name"}
        xalign={0}
        truncate={popup}
        label={notification.appName}
        hexpand
        wrap
      />
      <label
        class={"time"}
        xalign={1}
        label={time(notification.time)}
        hexpand
      />
      {Expand}
      {CloseRevealer}
    </box>
  );

  const Icon = (
    <box class={"icon"} valign={Gtk.Align.START} halign={Gtk.Align.CENTER}>
      {notificationIcon(notification)}
    </box>
  );

  const Content = (
    <box class={`notification ${notification.urgency} ${notification.appName}`}>
      <box class={"main-content"} spacing={10} vertical>
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
      $={() => {
        timeout(NOTIFICATION_DELAY, () => {
          if (!isLocked.get() && popup) closeNotification();
        });
      }}
    >
      <eventbox
        onHover={() => {
          (LeftRevealer as Gtk.Revealer).revealChild = true;
          (CloseRevealer as Gtk.Revealer).revealChild = true;
        }}
        onHoverLost={() => {
          if (!isLocked.get())
            (LeftRevealer as Gtk.Revealer).revealChild = false;
          (CloseRevealer as Gtk.Revealer).revealChild = false;
        }}
        onClick={() => {
          popup
            ? (LockButton as Gtk.Button).activate()
            : (CopyButton as Gtk.Button).activate();
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
        class={"image"}
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

  return <icon class={"icon"} icon={icon} />;
}
