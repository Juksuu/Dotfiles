import Mpris from "gi://AstalMpris";
import { Gtk } from "ags/gtk3";
import { Player } from "./Player";
import { createBinding, createState, With } from "ags";

export default function Media() {
  const mpris = Mpris.get_default();

  const [activePlayer, setActivePlayer] = createState<Mpris.Player | undefined>(
    undefined,
  );

  mpris.connect("player-added", (_, player) => {
    createBinding(player, "playbackStatus").subscribe(updateActivePlayer);
    updateActivePlayer();
  });

  mpris.connect("player-closed", () => {
    updateActivePlayer();
  });

  function updateActivePlayer() {
    if (mpris.players.length === 0) {
      setActivePlayer(undefined);
    } else {
      const player =
        mpris.players.find(
          (p) => p.playbackStatus === Mpris.PlaybackStatus.PLAYING,
        ) || mpris.players[0];

      setActivePlayer(player);
    }
  }

  function NoPlayerFound() {
    return (
      <box
        class={"module"}
        halign={Gtk.Align.CENTER}
        valign={Gtk.Align.CENTER}
        hexpand
      >
        <label label="No player found" />
      </box>
    );
  }

  updateActivePlayer();

  const player = activePlayer.as((player) => {
    if (!player) return <NoPlayerFound />;
    return <Player player={player} playerType={"widget"} />;
  });

  return (
    <box>
      <With value={player}>{(player) => player}</With>
    </box>
  );
}
