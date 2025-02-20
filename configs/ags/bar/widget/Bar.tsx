import { App, Astal, Gtk, Gdk } from "astal/gtk3"
import { CONFIG } from "../../common/config";
import WindowTitle from "./WindowTitle";

export default function Bar(gdkmonitor: Gdk.Monitor) {
    const { TOP, LEFT, RIGHT } = Astal.WindowAnchor

    return <window
        className="Bar"
        gdkmonitor={gdkmonitor}
        exclusivity={Astal.Exclusivity.EXCLUSIVE}
        anchor={TOP | LEFT | RIGHT}
        application={App}>
        <stack
            homogeneous={false}
            transition_type={Gtk.StackTransitionType.SLIDE_UP_DOWN}
            transition_duration={CONFIG.animations.durationLarge}>
            <centerbox
                className={'bar-bg'}
                startWidget={WindowTitle(gdkmonitor)}>
            </centerbox>
        </stack>
    </window >
}
