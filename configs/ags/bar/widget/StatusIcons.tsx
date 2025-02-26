import { bind, Variable } from "astal";
import { Icon, Label, Revealer } from "astal/gtk3/widget";
import { App, Gdk, Gtk, Widget } from "astal/gtk3";
import Notifd from "gi://AstalNotifd";
import Network from "gi://AstalNetwork";

import { CONFIG } from "../config";
import KeyboardLayout from "./KeyboardLayout";
import MaterialIcon from "../../common/widgets/MaterialIcon";

export default function StatusIcons(props: Widget.BoxProps, gdkMonitor: Gdk.Monitor) {
    const notifd = Notifd.get_default();
    const network = Network.get_default();

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

    const NetworkIndicator = Variable.derive(
        [bind(network, "state"), bind(network, "primary"), bind(network, "wifi"), bind(network, "wired")],
        (state, primary, wifi, wired) => {
            if (state <= Network.State.DISCONNECTING) {
                return MaterialIcon("mimo_disconnect", 12)
            }

            switch (primary) {
                case Network.Primary.WIFI: {
                    const icon = state === Network.State.CONNECTING ?
                        "settings_ethernet" :
                        `signal_wifi_${Math.ceil(wifi.strength / 25)}_bar`;
                    return MaterialIcon(icon, 12);
                }
                case Network.Primary.WIRED: {
                    const icon = state === Network.State.CONNECTING ? "settings_ethernet" : 'lan';
                    return MaterialIcon(icon, 12);
                }
                default:
                    return MaterialIcon("mimo_disconnect", 12)
            }
        }
    );

    return <box {...props}>
        <box className={"spacing-h-15"}>
            {KeyboardLayout(CONFIG.keyboard.useFlag)}
            {NotificationIndicator()}
            {NetworkIndicator()}
        </box>
    </box>
}
