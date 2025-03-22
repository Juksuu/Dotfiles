import { App, Gdk, Gtk, Widget } from "astal/gtk3";
import { getCssPath } from "./utils/scss";
import Bar from "./widgets/bar/Bar";
import { getMonitorPlugName } from "./utils/monitor";
import RightPanel from "./widgets/right-panel/RightPanel";

type MonitorWidgets = {
  visibleAtStart: Gtk.Widget[];
  hiddenAtStart: Gtk.Widget[];
};

function createWidgets(gdkmonitor: Gdk.Monitor, name: string): MonitorWidgets {
  return {
    visibleAtStart: [Bar(gdkmonitor, name)],
    hiddenAtStart: [RightPanel(gdkmonitor, name)],
  };
}

function updateMonitorWidgets(
  monitorWidgets: MonitorWidgets,
  newGdkMonitor: Gdk.Monitor,
) {
  for (const widget of monitorWidgets.visibleAtStart) {
    widget.visible = true;
    (widget as Widget.Window).gdkmonitor = newGdkMonitor;
  }
  for (const widget of monitorWidgets.hiddenAtStart) {
    widget.visible = false;
    (widget as Widget.Window).gdkmonitor = newGdkMonitor;
  }
}

App.start({
  css: getCssPath(),
  main() {
    const widgets = new Map<string, MonitorWidgets>();

    for (const gdkmonitor of App.get_monitors()) {
      const name = getMonitorPlugName(gdkmonitor);
      if (name) {
        widgets.set(name, createWidgets(gdkmonitor, name));
      }
    }

    App.connect("monitor-added", (_, newGdkMonitor) => {
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

    App.connect("monitor-removed", (_, gdkmonitor) => {
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
