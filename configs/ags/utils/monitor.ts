import { bind, Variable } from "astal";
import { App, Gdk } from "astal/gtk3";
import Hyprland from "gi://AstalHyprland";

export function getMonitorPlugName(gdkmonitor: Gdk.Monitor) {
  const display = gdkmonitor.display;
  const screen = display.get_default_screen();

  for (let i = 0; i < display.get_n_monitors(); ++i) {
    if (gdkmonitor === display.get_monitor(i))
      return screen.get_monitor_plug_name(i);
  }
}

export function getGdkMonitor(monitorPlugName: string) {
  for (const gdkMonitor of App.get_monitors()) {
    if (getMonitorPlugName(gdkMonitor) === monitorPlugName) {
      return gdkMonitor;
    }
  }
}

export function isMonitorWorkspaceEmpty(monitorIdentifier: string) {
  const hyprland = Hyprland.get_default();

  const clientMovedToCurrentMonitorWorkspace = Variable(false).observe(
    hyprland,
    "client-moved",
    (_, c: Hyprland.Client, ws: Hyprland.Workspace) => {
      const currentGdkMonitor = getGdkMonitor(monitorIdentifier);
      const hyprlandMonitor = hyprland.monitors.find(
        (m) => m.model === currentGdkMonitor?.model,
      );

      return ws.monitor.id === hyprlandMonitor?.id;
    },
  );

  return Variable.derive(
    [
      bind(hyprland, "clients"),
      bind(hyprland, "workspaces"),
      clientMovedToCurrentMonitorWorkspace,
    ],
    (_, ws, cmw) => {
      if (cmw) return false;

      const currentGdkMonitor = getGdkMonitor(monitorIdentifier);
      if (currentGdkMonitor) {
        const hyprlandMonitor = hyprland.monitors.find(
          (m) => m.model === currentGdkMonitor.model,
        );
        const monitorWorkspace = hyprland.workspaces.find(
          (w) => w.monitor.id === hyprlandMonitor?.id,
        );

        if (monitorWorkspace) {
          return monitorWorkspace.clients.length === 0;
        }
      }

      return true;
    },
  );
}
