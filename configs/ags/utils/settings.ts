import { readFile, writeFile } from "astal/file";
import { readJSONFile, writeJSONFile } from "./json";
import { exec } from "astal";

const settingsPath = "./assets/settings/settings.json";
const hyprlandCustomDir = "../hypr/hyprland/custom/settings.conf";

export type AdjustableSetting = {
  name: string;
  value: any;
  type: string;
  min: number;
  max: number;
};

export enum BarPosition {
  Top,
  Bottom,
}

export interface NestedSetting {
  [key: string]: AdjustableSetting | NestedSetting;
}

export function isAdjustableSetting(
  s: AdjustableSetting | NestedSetting,
): s is AdjustableSetting {
  return Object.keys(s).find((v) => v === "name") !== undefined;
}

export type Settings = {
  hyprland: {
    decoration: {
      rounding: AdjustableSetting;
      active_opacity: AdjustableSetting;
      inactive_opacity: AdjustableSetting;
      blur: {
        enabled: AdjustableSetting;
        size: AdjustableSetting;
        passes: AdjustableSetting;
      };
    };
  };
  notifications: {
    dnd: boolean;
  };
  globalOpacity: AdjustableSetting;
  globalIconSize: AdjustableSetting;
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
      rounding: { name: "rounding", value: 15, min: 0, max: 50, type: "int" },
      active_opacity: {
        name: "active opacity",
        value: 0.97,
        min: 0,
        max: 1,
        type: "float",
      },
      inactive_opacity: {
        name: "inactive opacity",
        value: 0.8,
        min: 0,
        max: 1,
        type: "float",
      },
      blur: {
        enabled: { name: "blur", value: true, type: "bool", min: 0, max: 1 },
        size: { name: "blur size", value: 3, type: "int", min: 0, max: 10 },
        passes: { name: "blur passes", value: 3, type: "int", min: 0, max: 10 },
      },
    },
  },
  notifications: {
    dnd: false,
  },
  globalOpacity: {
    name: "Global Opacity",
    value: 0.9,
    type: "float",
    min: 0,
    max: 1,
  },
  globalIconSize: {
    name: "Global Icon Size",
    value: 10,
    type: "int",
    min: 5,
    max: 20,
  },
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
  writeHyprlandSettings(defaultSettings.hyprland);
  return defaultSettings;
}

export function writeSettings(settings: Settings) {
  writeJSONFile(settingsPath, settings);
  writeHyprlandSettings(settings.hyprland);
}

function writeHyprlandSettings(settings: NestedSetting) {
  let settingsString = "";

  let nestLevel = 0;
  processNestedSettings(
    settings,
    "hyprland",
    (k) => {
      settingsString += "\t".repeat(nestLevel);

      const key = k.split(".").slice(-1);
      settingsString += `${key}\t{\n`;
      nestLevel++;
    },
    (p, k, v) => {
      const parent = k.split(".").slice(-1);
      settingsString += "\t".repeat(nestLevel);
      settingsString += `${parent}=${v.value}\n`;
    },
    () => {
      nestLevel--;
      settingsString += "\t".repeat(nestLevel);
      settingsString += `}\n`;
    },
  );

  if (readFile(hyprlandCustomDir) == "")
    exec(`mkdir -p ${hyprlandCustomDir.split("/").slice(0, -1).join("/")}`);
  try {
    writeFile(hyprlandCustomDir, settingsString);
  } catch (e) {
    console.error("Error:", e);
  }
}

export function processNestedSettings(
  data: AdjustableSetting | NestedSetting,
  parentKey: string,
  nestedCb: (path: string, key: string) => void,
  valueCb: (path: string, key: string, value: AdjustableSetting) => void,
  denestedCb: () => void,
  key?: string,
) {
  if (key) {
    parentKey += `.${key}`;
  }

  if (isAdjustableSetting(data)) {
    valueCb(parentKey, key ?? "", data);
  } else {
    if (key) {
      nestedCb(parentKey, key);
    }

    // Iterate over the entries of the current value
    for (const [childKey, childValue] of Object.entries(data)) {
      processNestedSettings(
        childValue,
        parentKey,
        nestedCb,
        valueCb,
        denestedCb,
        childKey,
      );
    }

    if (key) {
      denestedCb();
    }
  }
}
