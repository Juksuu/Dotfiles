import { readJSONFile, writeJSONFile } from "./json";

const settingsPath = "./assets/settings/settings.json";

export type HyprlandSetting = {
  value: any;
  type: string;
  min: number;
  max: number;
};

export enum BarPosition {
  Top,
  Bottom,
}

export type Settings = {
  hyprland: {
    decoration: {
      rounding: HyprlandSetting;
      active_opacity: HyprlandSetting;
      inactive_opacity: HyprlandSetting;
      blur: {
        enabled: HyprlandSetting;
        size: HyprlandSetting;
        passes: HyprlandSetting;
      };
    };
  };
  notifications: {
    dnd: boolean;
  };
  globalOpacity: number;
  bar: {
    position: BarPosition;
  };
  rightPanel: {
    exclusivity: boolean;
    width: number;
    widgets: string[];
  };
  quickLauncher: {
    apps: {
      name: string;
      app_name: string;
      exec: string;
      icon: string;
    }[];
  };
};

export const defaultSettings: Settings = {
  hyprland: {
    decoration: {
      rounding: { value: 15, min: 0, max: 50, type: "int" },
      active_opacity: { value: 0.8, min: 0, max: 1, type: "float" },
      inactive_opacity: { value: 0.5, min: 0, max: 1, type: "float" },
      blur: {
        enabled: { value: true, type: "bool", min: 0, max: 1 },
        size: { value: 3, type: "int", min: 0, max: 10 },
        passes: { value: 3, type: "int", min: 0, max: 10 },
      },
    },
  },
  notifications: {
    dnd: false,
  },
  globalOpacity: 1,
  bar: {
    position: BarPosition.Top,
  },
  rightPanel: {
    exclusivity: false,
    width: 300,
    widgets: [],
  },
  quickLauncher: {
    apps: [
      {
        name: "Browser",
        app_name: "zen-browser",
        exec: "zen-browser",
        icon: "",
      },
      { name: "Terminal", app_name: "kitty", exec: "kitty", icon: "" },
      { name: "Files", app_name: "thunar", exec: "thunar", icon: "" },
    ],
  },
};

function deepMerge(target: any, source: any): any {
  for (const key in source) {
    if (source.hasOwnProperty(key)) {
      const sourceValue = source[key];

      const targetValue = target[key];

      // Check if both values are objects and not arrays

      if (
        sourceValue &&
        typeof sourceValue === "object" &&
        !Array.isArray(sourceValue) &&
        targetValue &&
        typeof targetValue === "object" &&
        !Array.isArray(targetValue)
      ) {
        // Recursively merge objects if types match

        target[key] = deepMerge(targetValue, sourceValue);
      } else if (
        typeof sourceValue === typeof targetValue ||
        targetValue === undefined
      ) {
        // Assign source value if types match or if target doesn't have the key

        target[key] = sourceValue;
      }

      // If types don't match, prioritize the target's type by skipping the assignment
    }
  }
  return target;
}

export function createSettings() {
  if (Object.keys(readJSONFile(settingsPath)).length !== 0) {
    return deepMerge(defaultSettings, readJSONFile(settingsPath));
  }

  writeJSONFile(settingsPath, defaultSettings);
  return defaultSettings;
}

export function writeSettings(settings: Settings) {
  writeJSONFile(settingsPath, settings);
}
