import { bind } from "astal";
import { App, Astal, Gdk } from "astal/gtk3";
import {
  barOrientation,
  barVisibility,
  emptyWorkspace,
  DEFAULT_MARGIN,
} from "../../variables";
import BarLeft from "./components/BarLeft";
import BarMiddle from "./components/BarMiddle";
import BarRight from "./components/BarRight";

export default function Bar(gdkmonitor: Gdk.Monitor, monitorIndex: number) {
  return (
    <window
      name={`bar_${monitorIndex}`}
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
      margin={emptyWorkspace.as((empty) => (empty ? DEFAULT_MARGIN : 5))}
      visible={bind(barVisibility)}
    >
      <centerbox
        className={emptyWorkspace.as((empty) =>
          empty ? "bar empty" : "bar full",
        )}
        startWidget={
          <box name={"start-widget"}>
            <BarLeft />
          </box>
        }
        centerWidget={
          <box name={"center-widget"}>
            <BarMiddle />
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
