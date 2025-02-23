import { Astal, Gtk } from "astal/gtk3";
import { Button, Revealer, Icon } from "astal/gtk3/widget";
import { CONFIG } from "../config";
import Tray from "gi://AstalTray";
import { bind, Variable } from "astal";

export default function SystemTray() {
    const tray = Tray.get_default();

    const SysTrayItem = (item: Tray.TrayItem) => {
        console.log("testing item", item.id);
        if (item === null) return null;

        return <Button
            className={'bar-systray-item'}
            tooltipMarkup={item.tooltip_markup}
            onClick={(_, event) => {
                if (event.button === Astal.MouseButton.PRIMARY) {
                    item.activate(event.x, event.y);
                } else if (event.button === Astal.MouseButton.SECONDARY) {
                    item.secondary_activate(event.x, event.y)
                }
            }}>
            <Icon icon={item.iconName}></Icon>
        </Button>
    }

    const itemComponents = Variable.derive(
        [bind(tray, "items")],
        (items: Tray.TrayItem[]) => {
            return items.map(SysTrayItem)
        }
    );

    return <box>
        <Revealer
            revealChild={true}
            transitionType={Gtk.RevealerTransitionType.SLIDE_LEFT}
            transitionDuration={CONFIG.animations.durationLarge}>
            <box className={"margin-right-5 spacing-h-15"}>
                {itemComponents()}
            </box>
        </Revealer>
    </box>
}
