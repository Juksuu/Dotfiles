import { App, Gdk, Gtk } from "astal/gtk3";
import { getCssPath, refreshCss } from "./utils/scss";
import Bar from "./widgets/bar/Bar";

refreshCss();

App.start({
  css: getCssPath(),
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
  },
});
