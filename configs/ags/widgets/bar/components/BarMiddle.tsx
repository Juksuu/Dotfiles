import Mpris from "gi://AstalMpris";
import Hyprland from "gi://AstalHyprland";
import CustomRevealer from "./CustomRevealer";
import GLib from "gi://GLib?version=2.0";
import { Gtk } from "ags/gtk3";
import { createPoll } from "ags/time";
import { createBinding, createComputed, With } from "ags";
import { playerToIcon } from "../../../utils/icon";
import { TRANSITION_DURATION } from "../../../variables";
import { getGdkMonitor, isMonitorWorkspaceEmpty } from "../../../utils/monitor";

type Props = {
  monitorIdentifier: string;
};

export default function BarMiddle({ monitorIdentifier }: Props) {
  function Media() {
    const mpris = Mpris.get_default();

    const progress = (player?: Mpris.Player) => {
      if (!player) return <box />;

      const playerIcon = createBinding(player, "entry").as((e) =>
        playerToIcon(e),
      );
      return (
        <circularprogress
          class={"progress"}
          rounded
          borderWidth={1}
          value={createBinding(player, "position").as((p) =>
            player.length > 0 ? p / player.length : 0,
          )}
        >
          <label class={"icon"} label={playerIcon} />
        </circularprogress>
      );
    };

    const title = (player?: Mpris.Player) => {
      const title = player
        ? createBinding(player, "title").as((t) => t || "Unknown Track")
        : "Unknown Track";
      return (
        <label
          class={"label"}
          maxWidthChars={20}
          truncate
          label={title}
        ></label>
      );
    };

    const artist = (player?: Mpris.Player) => {
      const artist = player
        ? createBinding(player, "artist").as((a) => (a ? `[${a}]` : ""))
        : "";
      return (
        <label
          class={"label"}
          maxWidthChars={20}
          truncate
          label={artist}
        ></label>
      );
    };

    const coverArtToCss = (player?: Mpris.Player) => {
      if (player) {
        return createBinding(player, "coverArt").as(
          (c) => `
            background-image: linear-gradient(
                to right,
                #000000,
                rgba(0, 0, 0, 0.5)
              ),
              url("${c}");
          `,
        );
      }

      return `background-image: linear-gradient( to right, #000000, rgba(0, 0, 0, 0.5)); `;
    };

    function Player(player?: Mpris.Player) {
      return (
        <box class={"media"} css={coverArtToCss(player)} spacing={10}>
          {progress(player)}
          {title(player)}
          {artist(player)}
        </box>
      );
    }

    const activePlayer = () => {
      return createBinding(mpris, "players").as((players) => {
        const player =
          players.length > 0
            ? players.find(
                (player) =>
                  player.playbackStatus === Mpris.PlaybackStatus.PLAYING,
              ) || players[0]
            : undefined;
        return Player(player);
      });
    };

    return (
      <box class={"media-container"} halign={Gtk.Align.END} hexpand>
        <revealer
          revealChild={createBinding(mpris, "players").as(
            (arr) => arr.length > 0,
          )}
          transitionDuration={TRANSITION_DURATION}
          transitionType={Gtk.RevealerTransitionType.SLIDE_LEFT}
          halign={Gtk.Align.END}
          hexpand
        >
          <box class={"media-event"}>
            <With value={activePlayer()}>{(value) => value}</With>
          </box>
        </revealer>
      </box>
    );
  }

  const dateShort = createPoll(
    "",
    1000,
    () => GLib.DateTime.new_now_local().format("%H:%M") ?? "",
  );

  const dateLong = createPoll(
    "",
    1000,
    () => GLib.DateTime.new_now_local().format(":%S %b %e, %A.") ?? "",
  );

  function Clock() {
    const revealer = <label class={"revealer"} label={dateLong}></label>;
    const trigger = <label class={"trigger"} label={dateShort}></label>;
    return CustomRevealer(
      trigger as Gtk.Widget,
      revealer as Gtk.Widget,
      "clock",
    );
  }

  function ClientTitle() {
    const hyprland = Hyprland.get_default();

    const emptyWorkspace = isMonitorWorkspaceEmpty(monitorIdentifier);

    const focusedClient = createBinding(hyprland, "focusedClient").as(
      (client) => {
        const currentGdkMonitor = getGdkMonitor(monitorIdentifier);
        const hyprlandMonitor = hyprland.monitors.find(
          (m) => m.model === currentGdkMonitor?.model,
        );

        if (!client || client.monitor.id !== hyprlandMonitor?.id)
          return <box />;

        const text = createComputed(
          [createBinding(client, "class"), createBinding(client, "title")],
          (p, t) => `${p} ${t}`,
        );

        return <label maxWidthChars={30} truncate label={text} />;
      },
    );

    return (
      <box class={"focused-client"} halign={Gtk.Align.START} hexpand>
        <revealer
          revealChild={emptyWorkspace.as((empty) => !empty)}
          transitionDuration={TRANSITION_DURATION}
          transitionType={Gtk.RevealerTransitionType.SLIDE_RIGHT}
          halign={Gtk.Align.START}
          hexpand
        >
          <With value={focusedClient}>{(value) => value}</With>
        </revealer>
      </box>
    );
  }

  return (
    <box class={"bar-middle"} spacing={5} hexpand>
      <Media />
      <Clock />
      <ClientTitle />
    </box>
  );
}
