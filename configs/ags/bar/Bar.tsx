import { App, Astal, Gtk, Gdk } from "astal/gtk3"
import WindowTitle from "./widget/WindowTitle";
import Workspaces from "./widget/Workspaces";
import { CONFIG } from "./config";

export default function Bar(gdkmonitor: Gdk.Monitor) {
    const { TOP, LEFT, RIGHT } = Astal.WindowAnchor

    const SideModule = (children: JSX.Element[]) => <box
        className={'bar-sidemodule'}>
        {children}
    </box>;

    const CenterWidget = <box className={'spacing-h-4'}>
        {SideModule([])}
        {Workspaces()}
        {SideModule([])}
    </box>;

    return <window
        className={"Bar"}
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
                startWidget={WindowTitle(gdkmonitor)}
                center_widget={CenterWidget}>
            </centerbox>
        </stack>
    </window >
}
