import { bind } from "astal";
import { App, Gdk, Gtk } from "astal/gtk3";
import { EventBox, Revealer } from "astal/gtk3/widget";
import SystemTray from "./SystemTray";
import Tray from "gi://AstalTray";
import StatusIcons from "./StatusIcons";

export default function Indicators(gdkmonitor: Gdk.Monitor) {
    const tray = Tray.get_default();

    const ClickBox = (children: Gtk.Widget[]) => {
        return <EventBox>
            {children}
        </EventBox>
    }

    const SeparatorDot = () => {
        const update = (self: Revealer) => {
            const items = tray.items ?? [];
            self.set_reveal_child(items.length > 0)
        }

        return <Revealer
            transitionType={Gtk.RevealerTransitionType.SLIDE_LEFT}
            revealChild={false}
            setup={self => {
                update(self)
                self.hook(bind(tray, "items"), (self) => update(self))
            }}>
            <box className={'separator-circle'}></box>
        </Revealer>;
    }

    const EmptyArea = <box hexpand={true}></box>;
    const IndicatorArea = <box>
        {SeparatorDot()}
        {StatusIcons({
            className: "bar-statusicons",
            setup: (self) => {
                self.hook(bind(App, "activeWindow"), (self) => {
                    const active = App.active_window;
                    if (active.name === "sideright") {
                        self.toggleClassName('bar-statusicons-active', active.visible);
                    }
                })
            }
        }, gdkmonitor)}
    </box>;

    return <EventBox
    // onClick={() => App.toggle_window('sideright')}
    >
        <box>
            <box className={"spacing-h-5 bar-spaceright"} hexpand={true}>
                {ClickBox([EmptyArea])}
                {ClickBox([SystemTray()])}
                {ClickBox([IndicatorArea])}
            </box>
        </box>
    </EventBox >
}
