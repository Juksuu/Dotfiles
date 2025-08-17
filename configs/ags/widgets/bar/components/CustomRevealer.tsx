import { Gtk } from "ags/gtk3";
import { TRANSITION_DURATION } from "../../../variables";

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
      class={`custom-revealer ${customClass}`}
      onHover={() => {
        (revealer as Gtk.Revealer).revealChild = true;
      }}
      onHoverLost={() => {
        (revealer as Gtk.Revealer).revealChild = false;
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
