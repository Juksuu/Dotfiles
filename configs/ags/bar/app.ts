import { App } from "astal/gtk3"
import style from "./style.scss"
import Bar from "./widget/Bar"
import Hyprland from "gi://AstalHyprland";
import { execAsync } from 'astal/process';

const hyprland = Hyprland.get_default();

hyprland.connect("monitor-added", () => {
    execAsync(["bash", "-c", 'pkill ags-bar; ags-bar &']);
});

App.start({
    css: style,
    main() {
        App.get_monitors().map(Bar)
    },
})
