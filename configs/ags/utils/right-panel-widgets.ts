import { Gtk } from "astal/gtk3";
import Media from "../widgets/right-panel/components/Media";
import Calendar from "../widgets/right-panel/components/Calendar";
import NotificationHistory from "../widgets/right-panel/components/NotificationHistory";

export interface WidgetSelector {
  name: string;
  icon: string;
  widget: () => Gtk.Widget;
  widgetInstance?: Gtk.Widget;
}

// Name need to match the name of the widget()
export const WIDGET_SELECTORS: WidgetSelector[] = [
  {
    name: "Media",
    icon: "",
    widget: () => Media(),
  },
  {
    name: "NotificationHistory",
    icon: "",
    widget: () => NotificationHistory(),
  },
  {
    name: "Calendar",
    icon: "",
    widget: () => Calendar(),
  },
];
