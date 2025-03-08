import { App, Astal, Gdk, Widget } from "astal/gtk3";

type PopupWindowProps = Pick<
  Widget.WindowProps,
  "name" | "namespace" | "className" | "visible" | "child" | "anchor"
> & {
  onClose?(self: Widget.Window): void;
};

/**
 * Full screen window widget where you can space the child widget
 * using margins and alignment properties.
 *
 * NOTE: Child widgets will assume they can span across the full window width
 * this means that setting `wrap` or `ellipsize` on labels for example will not work
 * without explicitly setting its `max_width_chars` property.
 * For a workaround see Popover2.tsx
 */
export default function PopupWindow({
  child,
  onClose,
  ...props
}: PopupWindowProps) {
  return (
    <window
      {...props}
      css="background-color: transparent"
      keymode={Astal.Keymode.EXCLUSIVE}
      layer={Astal.Layer.OVERLAY}
      exclusivity={Astal.Exclusivity.NORMAL}
      visible={false}
      application={App}
      onNotifyVisible={(self) => {
        if (!self.visible) onClose?.(self);
      }}
      // close when click occurs outside of child
      onButtonPressEvent={(self, event) => {
        const [, _x, _y] = event.get_coords();
        const { x, y, width, height } = self.get_child()!.get_allocation();

        const xOut = _x < x || _x > x + width;
        const yOut = _y < y || _y > y + height;

        // clicked outside
        if (xOut || yOut) {
          self.visible = false;
        }
      }}
      // close when hitting Escape
      onKeyPressEvent={(self, event: Gdk.Event) => {
        if (event.get_keyval()[1] === Gdk.KEY_Escape) {
          self.visible = false;
        }
      }}
    >
      <box
        // make sure click event does not bubble up
        onButtonPressEvent={() => true}
      >
        {child}
      </box>
    </window>
  );
}
