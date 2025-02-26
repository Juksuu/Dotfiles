import { App, Astal, Gtk, Gdk } from "astal/gtk3";
import WindowTitle from "./widget/WindowTitle";
import Workspaces from "./widget/Workspaces";
import { CONFIG } from "./config";
import System from "./widget/System";
import Indicators from "./widget/Indicators";

export default function Bar(gdkmonitor: Gdk.Monitor, monitorIndex: number) {
  const { TOP, LEFT, RIGHT } = Astal.WindowAnchor;

  const SideModule = (children: Gtk.Widget[]) => (
    <box className={"bar-sidemodule"}>{children}</box>
  );

  const CenterWidget = (
    <box className={"spacing-h-4"}>
      {SideModule([])}
      {Workspaces()}
      {SideModule([System()])}
    </box>
  );

  return (
    <window
      name={`bar_${monitorIndex}`}
      className={"Bar"}
      gdkmonitor={gdkmonitor}
      exclusivity={Astal.Exclusivity.EXCLUSIVE}
      anchor={TOP | LEFT | RIGHT}
      application={App}
    >
      <stack
        homogeneous={false}
        transition_type={Gtk.StackTransitionType.SLIDE_UP_DOWN}
        transition_duration={CONFIG.animations.durationLarge}
      >
        <centerbox
          className={"bar-bg"}
          startWidget={WindowTitle(gdkmonitor)}
          center_widget={CenterWidget}
          endWidget={Indicators(gdkmonitor)}
        ></centerbox>
      </stack>
    </window>
  );
}
