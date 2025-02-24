import { App, Gdk, Gtk, Widget } from "astal/gtk3";
import KeyboardLayout from "./KeyboardLayout";
import { CONFIG } from "../config";
import { Label, Revealer } from "astal/gtk3/widget";
import Notifd from "gi://AstalNotifd";
import { bind } from "astal";
import MaterialIcon from "../../common/widgets/MaterialIcon";

export default function StatusIcons(props: Widget.BoxProps, gdkMonitor: Gdk.Monitor) {
    const notifd = Notifd.get_default();

    const Unread = (notifCenterName: string) => {
        return <label
            className={"txt-size-12"}
            setup={self => {
                self.hook(notifd, "notified", ((self, id) => {
                    if (!id || notifd.dontDisturb || !notifd.get_notification(id)) return;
                    self.label = notifd.get_notifications().length.toString();
                }));

                self.hook(bind(App, "activeWindow"), (self) => {
                    const active = App.active_window;
                    if (active.name === notifCenterName) {
                        self.label = "0";
                    }
                })
            }}>
        </label>;
    }

    const NotificationIndicator = (notifCenterName = 'sideright') => {
        return <Revealer
            transitionType={Gtk.RevealerTransitionType.SLIDE_LEFT}
            transitionDuration={CONFIG.animations.durationSmall}
            revealChild={false}
            setup={self => {
                self.hook(notifd, "notified", ((self, id) => {
                    if (!id || notifd.dontDisturb || !notifd.get_notification(id)) return;
                    self.set_reveal_child(true);
                }));

                self.hook(bind(App, "activeWindow"), (self) => {
                    const active = App.active_window;
                    if (active.name === notifCenterName) {
                        self.set_reveal_child(false);
                    }
                })
            }}>
            <box>
                {MaterialIcon("notifications", 14)}
                {Unread(notifCenterName)}
            </box>
        </Revealer>;
    }

    return <box {...props}>
        <box className={"spacing-h-15"}>
            {KeyboardLayout(CONFIG.keyboard.useFlag)}
            {NotificationIndicator()}
        </box>
    </box>
}
