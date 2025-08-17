import app from "ags/gtk3/app";
import BarLeft from "./components/BarLeft";
import BarMiddle from "./components/BarMiddle";
import BarRight from "./components/BarRight";
import { Astal, Gdk, Gtk } from "ags/gtk3";
import { BarPosition } from "../../utils/settings";
import { barPosition, DEFAULT_MARGIN } from "../../variables";
import { isMonitorWorkspaceEmpty } from "../../utils/monitor";

export default function Bar(
  gdkmonitor: Gdk.Monitor,
  monitorIdentifier: string,
) {
  const emptyWorkspace = isMonitorWorkspaceEmpty(monitorIdentifier);

  return (
    <window
      namespace={"bar"}
      gdkmonitor={gdkmonitor}
      application={app}
      name={`bar_${monitorIdentifier}`}
      class={"Bar"}
      exclusivity={Astal.Exclusivity.EXCLUSIVE}
      layer={Astal.Layer.TOP}
      anchor={barPosition.as((orientation) => {
        switch (orientation) {
          case BarPosition.Top:
            return (
              Astal.WindowAnchor.TOP |
              Astal.WindowAnchor.LEFT |
              Astal.WindowAnchor.RIGHT
            );
          case BarPosition.Bottom:
            return (
              Astal.WindowAnchor.BOTTOM |
              Astal.WindowAnchor.LEFT |
              Astal.WindowAnchor.RIGHT
            );
        }
      })}
      margin={emptyWorkspace.as((empty) => (empty ? DEFAULT_MARGIN : 5))}
    >
      <centerbox
        class={emptyWorkspace.as((empty) => {
          return empty ? "bar empty" : "bar full";
        })}
        startWidget={
          (
            <box name={"start-widget"}>
              <BarLeft monitorIdentifier={monitorIdentifier} />
            </box>
          ) as Gtk.Widget
        }
        centerWidget={
          (
            <box name={"center-widget"}>
              <BarMiddle monitorIdentifier={monitorIdentifier} />
            </box>
          ) as Gtk.Widget
        }
        endWidget={
          (
            <box name={"end-widget"}>
              <BarRight />
            </box>
          ) as Gtk.Widget
        }
      ></centerbox>
    </window>
  );
}
