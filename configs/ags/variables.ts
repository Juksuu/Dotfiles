import { createState } from "ags";
import { refreshCss } from "./utils/scss";
import {
  BarPosition,
  createSettings,
  AdjustableSetting,
  Settings,
  writeSettings,
} from "./utils/settings";

export const NOTIFICATION_DELAY = 5000;
export const DEFAULT_MARGIN = 14;
export const TRANSITION_DURATION = 500;

// Settings are stored in a json file, containing all the settings, check if it exists, if not, create it
export const [globalSettings, setGlobalSettings] =
  createState<Settings>(createSettings());
globalSettings.subscribe(() => writeSettings(globalSettings.get()));

export const [globalOpacity, setGlobalOpacity] = createState<AdjustableSetting>(
  getGlobalSetting("globalOpacity"),
);
globalOpacity.subscribe(() => {
  setGlobalSetting("globalOpacity", globalOpacity.get());
  refreshCss();
});

export const [globalIconSize, setGlobalIconSize] =
  createState<AdjustableSetting>(getGlobalSetting("globalIconSize"));
globalIconSize.subscribe(() => {
  setGlobalSetting("globalIconSize", globalIconSize.get());
  refreshCss();
});

export const [globalScale, setGlobalScale] = createState<AdjustableSetting>(
  getGlobalSetting("globalScale"),
);
globalScale.subscribe(() => {
  setGlobalSetting("globalScale", globalScale.get());
  refreshCss();
});

export const [globalFontSize, setGlobalFontSize] =
  createState<AdjustableSetting>(getGlobalSetting("globalFontSize"));
globalFontSize.subscribe(() => {
  setGlobalSetting("globalFontSize", globalFontSize.get());
  refreshCss();
});

export const [barPosition, setBarPosition] = createState<BarPosition>(
  getGlobalSetting("bar.position"),
);
barPosition.subscribe(() =>
  setGlobalSetting("bar.position", barPosition.get()),
);

export const [dnd, setDnd] = createState<boolean>(
  getGlobalSetting("notifications.dnd"),
);
dnd.subscribe(() => setGlobalSetting("notifications.dnd", dnd.get()));

// Some helper functions for getting and setting globalSettings values
export function setGlobalSetting(key: string, value: any): any {
  let o: any = globalSettings.get();
  key
    .split(".")
    .reduce(
      (o, k, i, arr) => (o[k] = i === arr.length - 1 ? value : o[k] || {}),
      o,
    );

  setGlobalSettings({ ...o });
}

export function getGlobalSetting(key: string): any {
  // returns the value of the key in the settings
  return key.split(".").reduce((o: any, k) => o?.[k], globalSettings.get());
}
