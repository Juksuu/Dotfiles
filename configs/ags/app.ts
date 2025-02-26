import { App } from "astal/gtk3"
import style from "./css/style.scss"
import Bar from "./bar/Bar"
import Hyprland from "gi://AstalHyprland";
import { execAsync } from 'astal/process';

const hyprland = Hyprland.get_default();

hyprland.connect("monitor-added", () => {
    execAsync(["bash", "-c", 'ags quit; ags-run']);
});

App.start({
    css: style,
    main() {
        App.get_monitors().map(Bar)
    },
})
