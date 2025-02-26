import { exec, Variable } from "astal";
import { Revealer } from "astal/gtk3/widget";
import Hyprland from "gi://AstalHyprland";
import { CONFIG } from "../config";
import { Gtk } from "astal/gtk3";

export default function KeyboardLayout(useFlag: boolean) {
  const hyprland = Hyprland.get_default();

  let languageStackArray: Gtk.Widget[] = [];

  let initLangs = [];
  const keyboards = JSON.parse(exec("hyprctl -j devices")).keyboards;

  for (const kb of keyboards) {
    initLangs.push(...kb.layout.split(",").map((lang: string) => lang.trim()));
  }

  initLangs = [...new Set(initLangs)];

  for (const lang of initLangs) {
    const data = CONFIG.keyboard.languages.find((l) => l.layout === lang);

    const label = !data ? (
      <label name={lang} label={lang} />
    ) : (
      <label name={lang} label={useFlag ? data.flag : data.layout} />
    );

    languageStackArray.push(label);
  }

  return (
    <Revealer
      transitionType={Gtk.RevealerTransitionType.SLIDE_LEFT}
      transitionDuration={CONFIG.animations.durationLarge}
      revealChild={languageStackArray.length > 1}
    >
      <stack
        transitionType={Gtk.StackTransitionType.SLIDE_UP_DOWN}
        transitionDuration={CONFIG.animations.durationLarge}
        setup={(self) => {
          self.hook(
            hyprland,
            "keyboard-layout",
            (self, _keyboard, layoutName) => {
              if (!layoutName) return;
              const layout =
                CONFIG.keyboard.languages.find((l) => l.name === layoutName)
                  ?.layout ?? "undef";
              self.set_shown(layout);
            },
          );
        }}
      >
        {...languageStackArray}
      </stack>
    </Revealer>
  );
}
