import Media from "../widgets/right-panel/components/Media";
import Calendar from "../widgets/right-panel/components/Calendar";
import NotificationHistory from "../widgets/right-panel/components/NotificationHistory";
import { Gtk } from "ags/gtk3";

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
    widget: () => Media() as Gtk.Widget,
  },
  {
    name: "NotificationHistory",
    icon: "",
    widget: () => NotificationHistory() as Gtk.Widget,
  },
  {
    name: "Calendar",
    icon: "",
    widget: () => Calendar() as Gtk.Widget,
  },
];
