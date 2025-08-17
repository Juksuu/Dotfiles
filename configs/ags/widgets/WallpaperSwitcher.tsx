import app from "ags/gtk3/app";
import { Gdk, Gtk } from "ags/gtk3";
import { execAsync } from "ags/process";
import { monitorFile } from "ags/file";
import { createState, For } from "ags";
import { TRANSITION_DURATION } from "../variables";
import { notify } from "../utils/notification";

const targetTypes = ["hyprpaper", "lockscreen"];
const [targetType, setTargetType] = createState<string>("hyprpaper");
const targetWallpapers: Record<string, string> = {
  ["hyprpaper"]: "../../wallpapers/current.wallp",
  ["lockscreen"]: "../../wallpapers/current_lockscreen.wallp",
};

const [wallpapers, setWallpapers] = createState<string[]>([]);
const [thumbnails, setThumbnails] = createState<string[]>([]);

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

    setWallpapers(wp);
    setThumbnails(tn);
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
    const images = thumbnails.as((tn) => {
      const wp = wallpapers.get();
      if (wp.length !== tn.length) return [<box />];
      return wp.map((wallpaper, index) => {
        return (
          <eventbox
            class={"wallpaper-event-box"}
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
              class={"wallpaper"}
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
        class={"all-wallpapers-scrollable"}
        hscrollbarPolicy={Gtk.PolicyType.ALWAYS}
        vscrollbarPolicy={Gtk.PolicyType.NEVER}
        hexpand
        vexpand
      >
        <box class={"all-wallpapers"} spacing={5}>
          <For each={images}>{(image) => image}</For>
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
            class={targetType.as((t) => {
              return t === target
                ? "workspace-wallpaper focused"
                : "workspace-wallpaper";
            })}
            label={target}
            onClicked={() => {
              setTargetType(target);
              (bottomRevealer as Gtk.Revealer).reveal_child = true;
            }}
          />
        ) as Gtk.Widget;
      });
    };

    const reset = (
      <button
        valign={Gtk.Align.CENTER}
        class={"reload-wallpapers"}
        label={"󰑐"}
        onClicked={() => {
          fetchWallpapers();
        }}
      />
    );

    const wallpaperList = wallpapers.as(() => getWallpapers());
    const top = (
      <box halign={Gtk.Align.CENTER} spacing={10} hexpand vexpand>
        <For each={wallpaperList}>{(wallpaper) => wallpaper}</For>
      </box>
    );

    const revealButton = (
      <Gtk.ToggleButton
        class={"bottom-revealer-button"}
        label={""}
        onToggled={(self) => {
          (bottomRevealer as Gtk.Revealer).reveal_child = self.active;
          self.label = self.active ? "" : "";
        }}
      />
    );

    const targets = (
      <box class={"targets"} halign={Gtk.Align.CENTER} hexpand>
        {targetTypes.map((type) => (
          <Gtk.ToggleButton
            valign={Gtk.Align.CENTER}
            class={type}
            label={type}
            active={targetType.as((t) => t === type)}
            onToggled={() => {
              setTargetType(type);
            }}
          />
        ))}
      </box>
    );

    const actions = (
      <box class={"actions"} halign={Gtk.Align.CENTER} spacing={10} hexpand>
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
        <box>{getAllWallpapers()}</box>
      </revealer>
    );

    const bottom = (
      <box class={"bottom"} hexpand vexpand>
        {bottomRevealer}
      </box>
    );

    return (
      <box class={"wallpaper-switcher"} spacing={20} vertical>
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
      application={app}
      visible={false}
    >
      <Wallpapers />
    </window>
  );
}
