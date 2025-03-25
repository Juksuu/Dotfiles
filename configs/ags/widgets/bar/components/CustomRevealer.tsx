import { Gtk } from "astal/gtk3";
import { TRANSITION_DURATION } from "../../../variables";
import { Revealer } from "astal/gtk3/widget";

export default function CustomRevealer(
  trigger: Gtk.Widget,
  child: Gtk.Widget,
  customClass = "",
  onPrimaryClick?: () => void,
  vertical = false,
) {
  const revealer = (
    <revealer
      transitionDuration={TRANSITION_DURATION}
      transitionType={
        vertical
          ? Gtk.RevealerTransitionType.SLIDE_UP
          : Gtk.RevealerTransitionType.SLIDE_RIGHT
      }
    >
      {child}
    </revealer>
  );

  return (
    <eventbox
      className={`custom-revealer ${customClass}`}
      onHover={() => {
        (revealer as Revealer).revealChild = true;
      }}
      onHoverLost={() => {
        (revealer as Revealer).revealChild = false;
      }}
      onClick={onPrimaryClick}
    >
      <box vertical={vertical}>
        {trigger}
        {revealer}
      </box>
    </eventbox>
  );
}
