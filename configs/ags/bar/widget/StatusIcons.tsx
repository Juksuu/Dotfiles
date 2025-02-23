import { App, Gdk, Widget } from "astal/gtk3";
import KeyboardLayout from "./KeyboardLayout";
import { CONFIG } from "../config";

export default function StatusIcons(props: Widget.BoxProps, gdkMonitor: Gdk.Monitor) {
    return <box {...props}>
        <box className={"spacing-h-15"}>
            {KeyboardLayout(CONFIG.keyboard.useFlag)}
        </box>
    </box>
}
