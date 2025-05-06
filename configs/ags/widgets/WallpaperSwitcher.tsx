import { bind, execAsync, monitorFile, Variable } from "astal";
import { App, Gdk, Gtk } from "astal/gtk3";
import { notify } from "../utils/notification";
import ToggleButton from "./ToggleButton";
import { Revealer } from "astal/gtk3/widget";
import { TRANSITION_DURATION } from "../variables";

const targetTypes = ["hyprpaper", "lockscreen"];
const targetType = Variable<string>("hyprpaper");
const targetWallpapers: Record<string, string> = {
  ["hyprpaper"]: "../../wallpapers/current.wallp",
  ["lockscreen"]: "../../wallpapers/current_lockscreen.wallp",
};

const wallpapers = Variable<string[]>([]);
const thumbnails = Variable<string[]>([]);

async function fetchWallpapers() {
  try {
    await execAsync(
      'bash -c "~/scripts/theme/wallpaper.sh generate_thumbnails"',
    );

    let [wp, tn] = await Promise.all([
      execAsync('bash -c "~/scripts/theme/wallpaper.sh get_wallpapers"').then(
        (v) => {
          return JSON.parse(v) as string[];
        },
      ),
      execAsync('bash -c "~/scripts/theme/wallpaper.sh get_thumbnails"').then(
        (v) => {
          return JSON.parse(v) as string[];
        },
      ),
    ]);

    wallpapers.set(wp);
    thumbnails.set(tn);
  } catch (err) {
    notify({ summary: "Error fetching wallpapers", body: String(err) });
  }
}

fetchWallpapers();
monitorFile("../../wallpapers", fetchWallpapers);

export default function WallpaperSwitcher(
  gdkmonitor: Gdk.Monitor,
  monitorIdentifier: string,
) {
  function Wallpapers() {
    const images = Variable.derive([bind(thumbnails)], (tn) => {
      const wp = wallpapers.get();
      if (wp.length !== tn.length) return <box />;
      return wp.map((wallpaper, index) => {
        return (
          <eventbox
            className={"wallpaper-event-box"}
            onClick={() => {
              const target = targetType.get();
              const command = {
                hyprpaper: `bash -c "~/scripts/theme/wallpaper.sh set_current ${wallpaper}"`,
                lockscreen: `bash -c "~/scripts/theme/wallpaper.sh set_current_lockscreen ${wallpaper}"`,
              }[target];

              execAsync(command!)
                .then(() => {
                  notify({
                    summary: "WallpaperSwitcher",
                    body: "Wallpaper changed successfully!",
                  });
                })
                .catch(notify);
            }}
          >
            <box
              className={"wallpaper"}
              vertical
              css={`
                background-image: url("${tn[index]}");
              `}
            />
          </eventbox>
        );
      });
    });

    const getAllWallpapers = () => (
      <scrollable
        className={"all-wallpapers-scrollable"}
        hscrollbarPolicy={Gtk.PolicyType.ALWAYS}
        vscrollbarPolicy={Gtk.PolicyType.NEVER}
        hexpand
        vexpand
      >
        <box className={"all-wallpapers"} spacing={5}>
          {bind(images)}
        </box>
      </scrollable>
    );

    const getWallpapers = () => {
      return targetTypes.map((target) => {
        return (
          <button
            valign={Gtk.Align.CENTER}
            css={`
              background-image: url("${targetWallpapers[target]}");
            `}
            className={bind(targetType).as((t) => {
              return t === target
                ? "workspace-wallpaper focused"
                : "workspace-wallpaper";
            })}
            label={target}
            onClicked={() => {
              targetType.set(target);
              (bottomRevealer as Revealer).reveal_child = true;
            }}
          />
        );
      });
    };

    const reset = (
      <button
        valign={Gtk.Align.CENTER}
        className={"reload-wallpapers"}
        label={"󰑐"}
        onClicked={() => {
          fetchWallpapers();
        }}
      />
    );

    const top = (
      <box halign={Gtk.Align.CENTER} spacing={10} hexpand vexpand>
        {bind(wallpapers).as((w) => getWallpapers())}
      </box>
    );

    const revealButton = (
      <ToggleButton
        className={"bottom-revealer-button"}
        label={""}
        onToggled={(self, on) => {
          (bottomRevealer as Revealer).reveal_child = on;
          self.label = on ? "" : "";
        }}
      />
    );

    const targets = (
      <box className={"targets"} halign={Gtk.Align.CENTER} hexpand>
        {targetTypes.map((type) => (
          <ToggleButton
            valign={Gtk.Align.CENTER}
            className={type}
            label={type}
            state={bind(targetType).as((t) => t === type)}
            onToggled={() => {
              targetType.set(type);
            }}
          />
        ))}
      </box>
    );

    const actions = (
      <box className={"actions"} halign={Gtk.Align.CENTER} spacing={10} hexpand>
        {targets}
        {revealButton}
        {reset}
      </box>
    );

    const bottomRevealer = (
      <revealer
        transitionType={Gtk.RevealerTransitionType.SLIDE_DOWN}
        transition_duration={TRANSITION_DURATION}
        reveal_child={false}
        visible
      >
        <box child={getAllWallpapers()}></box>
      </revealer>
    );

    const bottom = (
      <box className={"bottom"} hexpand vexpand>
        {bottomRevealer}
      </box>
    );

    return (
      <box className={"wallpaper-switcher"} spacing={20} vertical>
        {top}
        {actions}
        {bottom}
      </box>
    );
  }

  return (
    <window
      namespace={"wallpaper-switcher"}
      gdkmonitor={gdkmonitor}
      name={`wallpaper_switcher_${monitorIdentifier}`}
      application={App}
      visible={false}
    >
      <Wallpapers />
    </window>
  );
}
