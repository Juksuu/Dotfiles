import { App, Gdk, Gtk } from "astal/gtk3";
import style from "./css/style.scss";
import Bar from "./bar/Bar";
import Overview from "./overview/Overview";

App.start({
  css: style,
  main() {
    let monitorId = 0;

    const bars = new Map<Gdk.Monitor, Gtk.Widget>();
    for (const gdkmonitor of App.get_monitors()) {
      bars.set(gdkmonitor, Bar(gdkmonitor, monitorId++));
    }

    App.connect("monitor-added", (_, gdkmonitor) => {
      bars.set(gdkmonitor, Bar(gdkmonitor, monitorId++));
    });

    App.connect("monitor-removed", (_, gdkmonitor) => {
      bars.get(gdkmonitor)?.destroy();
      bars.delete(gdkmonitor);
    });

    Overview();
  },
});
