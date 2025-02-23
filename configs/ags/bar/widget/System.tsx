import { execAsync, Variable } from "astal";
import { App, Gtk } from "astal/gtk3";
import { EventBox } from "astal/gtk3/widget";
import { CONFIG } from "../config";
import GLib from "gi://GLib";

type UtilButtonProps = {
    name: string;
    icon: string;
    onClicked: () => void;
};

export default function System() {
    const time = Variable('');
    time.poll(CONFIG.time.interval, () =>
        GLib.DateTime.new_now_local().format(CONFIG.time.format) as string
    );

    const date = Variable('');
    date.poll(CONFIG.time.dateInterval, () =>
        GLib.DateTime.new_now_local().format(CONFIG.time.dateFormatLong) as string
    );

    const BarGroup = (children: Gtk.Widget[]) => {
        return <box
            className={'bar-group-margin'}>
            <box className={'bar-group bar-group-standalone bar-group-pad-system'}>
                {children}
            </box>
        </box>;
    }

    const BarClock = () => {
        return <box className={'spacing-h-4 bar-clock-box'}>
            <label className={'bar-time'} label={time()}></label>
            <label className={'txt-size-14 txt-onLayer1'} label={"•"}></label>
            <label className={'txt-size-11 bar-date'} label={date()}></label>
        </box >;
    }

    const UtilButton = (props: UtilButtonProps) => {
        return <button
            className={"bar-util-btn icon-material txt-size-14"}
            tooltipText={props.name}
            onClick={props.onClicked}
            label={props.icon}>
        </button>;
    }

    const Utilities = () => {
        return <box className={"spacing-h-4"}>
            {UtilButton({
                name: "Screen snip", icon: 'screenshot_region', onClicked: () => {
                    execAsync('~/scripts/grimblast.sh copy area')
                }
            })}
            {UtilButton({
                name: "Color picker", icon: 'colorize', onClicked: () => {
                    execAsync(['hyprpicker', "-a"])
                }
            })}
        </box>
    }

    return <EventBox
    // onClick={() => App.toggle_window('sideright')}
    >
        <box className={"spacing-h-4"}>
            {BarGroup([BarClock()])}
            {BarGroup([Utilities()])}
        </box>
    </EventBox >
}
