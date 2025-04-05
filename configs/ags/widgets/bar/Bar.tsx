import { bind } from "astal";
import { App, Astal, Gdk } from "astal/gtk3";
import { barPosition, DEFAULT_MARGIN } from "../../variables";
import BarLeft from "./components/BarLeft";
import BarMiddle from "./components/BarMiddle";
import BarRight from "./components/BarRight";
import { isMonitorWorkspaceEmpty } from "../../utils/monitor";
import { BarPosition } from "../../utils/settings";

export default function Bar(
  gdkmonitor: Gdk.Monitor,
  monitorIdentifier: string,
) {
  const emptyWorkspace = isMonitorWorkspaceEmpty(monitorIdentifier);

  return (
    <window
      namespace={"bar"}
      gdkmonitor={gdkmonitor}
      application={App}
      name={`bar_${monitorIdentifier}`}
      className={"Bar"}
      exclusivity={Astal.Exclusivity.EXCLUSIVE}
      layer={Astal.Layer.TOP}
      anchor={bind(barPosition).as((orientation) => {
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
      margin={bind(emptyWorkspace).as((empty) => (empty ? DEFAULT_MARGIN : 5))}
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
