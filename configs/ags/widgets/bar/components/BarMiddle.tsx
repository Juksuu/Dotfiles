import { bind, GLib, Variable } from "astal";
import Mpris from "gi://AstalMpris";
import { playerToIcon } from "../../../utils/icon";
import { playerToColor } from "../../../utils/color";
import { Gtk } from "astal/gtk3";
import { TRANSITION_DURATION } from "../../../variables";
import CustomRevealer from "./CustomRevealer";
import Hyprland from "gi://AstalHyprland";
import { getGdkMonitor, isMonitorWorkspaceEmpty } from "../../../utils/monitor";

type Props = {
  monitorIdentifier: string;
};

export default function BarMiddle({ monitorIdentifier }: Props) {
  function Media() {
    const mpris = Mpris.get_default();

    const progress = (player?: Mpris.Player) => {
      if (!player) return <box />;

      const playerIcon = bind(player, "entry").as((e) => playerToIcon(e));
      return (
        <circularprogress
          className={"progress"}
          rounded
          borderWidth={1}
          value={bind(player, "position").as((p) =>
            player.length > 0 ? p / player.length : 0,
          )}
        >
          <label className={"icon"} label={playerIcon} />
        </circularprogress>
      );
    };

    const title = (player?: Mpris.Player) => {
      const title = player
        ? bind(player, "title").as((t) => t || "Unknown Track")
        : "Unknown Track";
      return (
        <label
          className={"label"}
          maxWidthChars={20}
          truncate
          label={title}
        ></label>
      );
    };

    const artist = (player?: Mpris.Player) => {
      const artist = player
        ? bind(player, "artist").as((a) => (a ? `[${a}]` : ""))
        : "";
      return (
        <label
          className={"label"}
          maxWidthChars={20}
          truncate
          label={artist}
        ></label>
      );
    };

    const coverArtToCss = (player?: Mpris.Player) => {
      if (player) {
        return bind(player, "coverArt").as(
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
        <box className={"media"} css={coverArtToCss(player)} spacing={10}>
          {progress(player)}
          {title(player)}
          {artist(player)}
        </box>
      );
    }

    const activePlayer = () => {
      return bind(mpris, "players").as((players) => {
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
      <box className={"media-container"} halign={Gtk.Align.END} hexpand>
        <revealer
          revealChild={bind(mpris, "players").as((arr) => arr.length > 0)}
          transitionDuration={TRANSITION_DURATION}
          transitionType={Gtk.RevealerTransitionType.SLIDE_LEFT}
          halign={Gtk.Align.END}
          hexpand
        >
          <box className={"media-event"}>{activePlayer()}</box>
        </revealer>
      </box>
    );
  }

  const dateShort = Variable("").poll(
    1000,
    () => GLib.DateTime.new_now_local().format("%H:%M") ?? "",
  );

  const dateLong = Variable("").poll(
    1000,
    () => GLib.DateTime.new_now_local().format(":%S %b %e, %A.") ?? "",
  );

  function Clock() {
    const revealer = (
      <label className={"revealer"} label={bind(dateLong)}></label>
    );
    const trigger = (
      <label className={"trigger"} label={bind(dateShort)}></label>
    );
    return CustomRevealer(trigger, revealer, "clock");
  }

  function ClientTitle() {
    const hyprland = Hyprland.get_default();

    const emptyWorkspace = isMonitorWorkspaceEmpty(monitorIdentifier);

    return (
      <box className={"focused-client"} halign={Gtk.Align.START} hexpand>
        <revealer
          revealChild={bind(emptyWorkspace).as((empty) => !empty)}
          transitionDuration={TRANSITION_DURATION}
          transitionType={Gtk.RevealerTransitionType.SLIDE_RIGHT}
          halign={Gtk.Align.START}
          hexpand
        >
          {bind(hyprland, "focusedClient").as((client) => {
            const currentGdkMonitor = getGdkMonitor(monitorIdentifier);
            const hyprlandMonitor = hyprland.monitors.find(
              (m) => m.model === currentGdkMonitor?.model,
            );

            if (!client || client.monitor.id !== hyprlandMonitor?.id)
              return <box />;

            const text = Variable.derive(
              [bind(client, "class"), bind(client, "title")],
              (p, t) => `${p} ${t}`,
            );

            return <label maxWidthChars={30} truncate label={bind(text)} />;
          })}
        </revealer>
      </box>
    );
  }

  return (
    <box className={"bar-middle"} spacing={5} hexpand>
      <Media />
      <Clock />
      <ClientTitle />
    </box>
  );
}
