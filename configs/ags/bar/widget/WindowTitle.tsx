import { bind, Variable } from "astal";
import { Gdk, Gtk } from "astal/gtk3";
import Hyprland from "gi://AstalHyprland";

export default function WindowTitle(gdkmonitor: Gdk.Monitor) {
    const hyprland = Hyprland.get_default();

    const classComponent = Variable.derive(
        [bind(hyprland, 'focused_client')],
        (client: Hyprland.Client) => {
            let text = "Desktop";
            if (client && client.class.length > 0) {
                text = client.class;
            }

            return <label
                className={'txt-size-10 bar-wintitle-topdesc txt'}
                xalign={0}
                truncate={true}
                max_width_chars={1}
                label={text}>
            </label >
        });

    const titleComponent = Variable.derive(
        [bind(hyprland, 'focused_client')],
        (client: Hyprland.Client) => {
            let text = `Workspace ${hyprland.focused_workspace.id}`;
            if (client && client.title.length > 0) {
                text = client.title;
            }

            return <label
                className={'txt-size-11 bar-wintitle-txt'}
                xalign={0}
                truncate={true}
                max_width_chars={1}
                label={text}>
            </label >
        });

    return <box
        homogeneous={false}>
        <box className={'bar-corner-spacing'}></box>
        <overlay overlays={[
            <box hexpand={true}></box>,
            <box className={'bar-sidemodule'} hexpand={true}>
                <box className={'bar-space-button'} vertical={true}>
                    <box vertical={true} hexpand={true}>
                        {classComponent()}
                        {titleComponent()}
                    </box>
                </box>
            </box>
        ]
        }></overlay >
    </box >
}
