import app from "ags/gtk3/app";
import { Astal, Gdk, Gtk } from "ags/gtk3";
import { getCssPath } from "./utils/scss";
import Bar from "./widgets/bar/Bar";
import { getMonitorPlugName } from "./utils/monitor";
import RightPanel from "./widgets/right-panel/RightPanel";
import NotificationPopups from "./widgets/NotificationPopups";
import Settings from "./widgets/Settings";
import WallpaperSwitcher from "./widgets/WallpaperSwitcher";

type MonitorWidgets = {
  visibleAtStart: Gtk.Widget[];
  hiddenAtStart: Gtk.Widget[];
};

function createWidgets(gdkmonitor: Gdk.Monitor, name: string): MonitorWidgets {
  return {
    visibleAtStart: [Bar(gdkmonitor, name) as Gtk.Widget],
    hiddenAtStart: [
      RightPanel(gdkmonitor, name) as Gtk.Widget,
      NotificationPopups(gdkmonitor, name) as Gtk.Widget,
      Settings(gdkmonitor, name) as Gtk.Widget,
      WallpaperSwitcher(gdkmonitor, name) as Gtk.Widget,
    ],
  };
}

function updateMonitorWidgets(
  monitorWidgets: MonitorWidgets,
  newGdkMonitor: Gdk.Monitor,
) {
  for (const widget of monitorWidgets.visibleAtStart) {
    widget.visible = true;
    (widget as Astal.Window).gdkmonitor = newGdkMonitor;
  }
  for (const widget of monitorWidgets.hiddenAtStart) {
    widget.visible = false;
    (widget as Astal.Window).gdkmonitor = newGdkMonitor;
  }
}

app.start({
  css: getCssPath(),
  main() {
    const widgets = new Map<string, MonitorWidgets>();

    for (const gdkmonitor of app.get_monitors()) {
      const name = getMonitorPlugName(gdkmonitor);
      if (name) {
        widgets.set(name, createWidgets(gdkmonitor, name));
      }
    }

    app.connect("monitor-added", (_, newGdkMonitor) => {
      const name = getMonitorPlugName(newGdkMonitor);
      if (name) {
        const monitorWidgets = widgets.get(name);
        if (monitorWidgets) {
          updateMonitorWidgets(monitorWidgets, newGdkMonitor);
        } else {
          widgets.set(name, createWidgets(newGdkMonitor, name));
        }
      }
    });

    app.connect("monitor-removed", (_, gdkmonitor) => {
      const name = getMonitorPlugName(gdkmonitor);
      if (name) {
        const monitorWidgets = widgets.get(name);
        if (monitorWidgets) {
          for (const widget of [
            ...monitorWidgets.visibleAtStart,
            ...monitorWidgets.hiddenAtStart,
          ]) {
            widget.visible = false;
          }
        }
      }
    });
  },
});
