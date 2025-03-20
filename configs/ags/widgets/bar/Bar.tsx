import { bind, Variable } from "astal";
import { App, Astal, Gdk } from "astal/gtk3";
import { barOrientation, barVisibility, DEFAULT_MARGIN } from "../../variables";
import BarLeft from "./components/BarLeft";
import BarMiddle from "./components/BarMiddle";
import BarRight from "./components/BarRight";
import Hyprland from "gi://AstalHyprland";
import { getGdkMonitor, isMonitorWorkspaceEmpty } from "../../utils/monitor";

export default function Bar(
  gdkmonitor: Gdk.Monitor,
  monitorIdentifier: string,
) {
  const emptyWorkspace = isMonitorWorkspaceEmpty(monitorIdentifier);

  return (
    <window
      name={`bar_${monitorIdentifier}`}
      className={"Bar"}
      gdkmonitor={gdkmonitor}
      application={App}
      exclusivity={Astal.Exclusivity.EXCLUSIVE}
      layer={Astal.Layer.TOP}
      anchor={bind(barOrientation).as((orientation) => {
        return orientation
          ? Astal.WindowAnchor.TOP |
              Astal.WindowAnchor.LEFT |
              Astal.WindowAnchor.RIGHT
          : Astal.WindowAnchor.BOTTOM |
              Astal.WindowAnchor.LEFT |
              Astal.WindowAnchor.RIGHT;
      })}
      margin={bind(emptyWorkspace).as((empty) => (empty ? DEFAULT_MARGIN : 5))}
      visible={bind(barVisibility)}
    >
      <centerbox
        className={bind(emptyWorkspace).as((empty) => {
          return empty ? "bar empty" : "bar full";
        })}
        startWidget={
          <box name={"start-widget"}>
            <BarLeft />
          </box>
        }
        centerWidget={
          <box name={"center-widget"}>
            <BarMiddle monitorIdentifier={monitorIdentifier} />
          </box>
        }
        endWidget={
          <box name={"end-widget"}>
            <BarRight />
          </box>
        }
      ></centerbox>
    </window>
  );
}
