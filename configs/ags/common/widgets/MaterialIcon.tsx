import { Widget } from "astal/gtk3";

export default function MaterialIcon(
  icon: string,
  size: number,
  props?: Widget.LabelProps,
) {
  return (
    <label
      {...props}
      className={`icon-material txt-size-${size}`}
      label={icon}
    />
  );
}
