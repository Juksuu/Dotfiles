import { Variable } from "astal";
import { refreshCss } from "./utils/scss";
import {
  BarPosition,
  createSettings,
  Settings,
  writeSettings,
} from "./utils/settings";

export const NOTIFICATION_DELAY = 5000;
export const DEFAULT_MARGIN = 14;
export const TRANSITION_DURATION = 500;
export const WIDGET_LIMIT = 5;

export const newAppWorkspace = Variable(0);
export const userPanelVisibility = Variable(false);
export const settingsVisibility = Variable(false);
export const appLauncherVisibility = Variable(false);

// Settings are stored in a json file, containing all the settings, check if it exists, if not, create it
export const globalSettings = Variable<Settings>(createSettings());
globalSettings.subscribe((value) => writeSettings(value));

export const globalOpacity = Variable<number>(
  getGlobalSetting("globalOpacity"),
);
globalOpacity.subscribe((value) => {
  setGlobalSetting("globalOpacity", value);
  refreshCss();
});

export const barPosition = Variable<BarPosition>(
  getGlobalSetting("bar.position"),
);
barPosition.subscribe((value) => setGlobalSetting("bar.position", value));

export const dnd = Variable<boolean>(getGlobalSetting("notifications.dnd"));
dnd.subscribe((value) => setGlobalSetting("notifications.dnd", value));

export const rightPanelExclusivity = Variable<boolean>(
  getGlobalSetting("rightPanel.exclusivity"),
);
rightPanelExclusivity.subscribe((value) =>
  setGlobalSetting("rightPanel.exclusivity", value),
);
// export const rightPanelWidth = Variable<number>(
//   getGlobalSetting("rightPanel.width"),
// );
// rightPanelWidth.subscribe((value) =>
//   setGlobalSetting("rightPanel.width", value),
// );

// export const widgets = Variable<WidgetSelector[]>(
//   getSetting("rightPanel.widgets").map((name: string) =>
//     WidgetSelectors.find((widget) => widget.name === name),
//   ),
// );
// widgets.subscribe((value) =>
//   setSetting(
//     "rightPanel.widgets",
//     value.map((widget) => widget.name),
//   ),
// );

// Some helper functions for getting and setting globalSettings values
export function setGlobalSetting(key: string, value: any): any {
  let o: any = globalSettings.get();
  key
    .split(".")
    .reduce(
      (o, k, i, arr) => (o[k] = i === arr.length - 1 ? value : o[k] || {}),
      o,
    );

  globalSettings.set({ ...o });
}

export function getGlobalSetting(key: string): any {
  // returns the value of the key in the settings
  return key.split(".").reduce((o: any, k) => o?.[k], globalSettings.get());
}
