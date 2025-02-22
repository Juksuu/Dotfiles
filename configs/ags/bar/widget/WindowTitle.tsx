import { bind, Variable } from "astal";
import { Gdk, Gtk } from "astal/gtk3";
import Hyprland from "gi://AstalHyprland";

export default function WindowTitle(gdkmonitor: Gdk.Monitor) {
    const hyprland = Hyprland.get_default();

    const classComponent = Variable.derive(
        [bind(hyprland, 'focused_client')],
        (client: Hyprland.Client) => {
            return <label
                className={'txt-size-10 bar-wintitle-topdesc txt'}
                xalign={0}
                truncate={true}
                max_width_chars={1}
                label={client.class.length === 0 ? "Desktop" : client.class}>
            </label >
        });

    const titleComponent = Variable.derive(
        [bind(hyprland, 'focused_client')],
        (client: Hyprland.Client) => {
            return <label
                className={'txt-size-11 bar-wintitle-txt'}
                xalign={0}
                truncate={true}
                max_width_chars={1}
                label={
                    client.title.length === 0
                        ? `Workspace ${hyprland.focused_workspace.id}`
                        : client.title}>
            </label >
        });

    return <box
        homogeneous={false}>
        <box className={'bar-corner-spacing'}></box>
        <overlay overlays={[
            <box hexpand={true}></box>,
            <box className={'bar-sidemodule'} hexpand={true}>
                <box className={'bar-space-button'} vertical={true}>
                    <scrollable
                        hexpand={true}
                        hscroll={Gtk.PolicyType.AUTOMATIC}
                        vscroll={Gtk.PolicyType.NEVER}>
                        <box vertical={true}>
                            {classComponent()}
                            {titleComponent()}
                        </box>
                    </scrollable>
                </box>
            </box>
        ]
        }></overlay >
    </box >
}
