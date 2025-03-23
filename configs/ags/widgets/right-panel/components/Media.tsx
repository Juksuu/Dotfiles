import { Gtk } from "astal/gtk3";
import Mpris from "gi://AstalMpris";
import { Player } from "./Player";
import { bind, Variable } from "astal";

export default function Media() {
  const mpris = Mpris.get_default();

  const activePlayer = Variable<Mpris.Player | undefined>(undefined);

  mpris.connect("player-added", (_, player) => {
    bind(player, "playbackStatus").subscribe(updateActivePlayer);
  });

  function updateActivePlayer() {
    if (mpris.players.length === 0) {
      activePlayer.set(undefined);
    } else {
      const player =
        mpris.players.find(
          (p) => p.playbackStatus === Mpris.PlaybackStatus.PLAYING,
        ) || mpris.players[0];

      activePlayer.set(player);
    }
  }

  function NoPlayerFound() {
    return (
      <box
        className={"module"}
        halign={Gtk.Align.CENTER}
        valign={Gtk.Align.CENTER}
        hexpand
      >
        <label label="No player found" />
      </box>
    );
  }

  updateActivePlayer();

  return (
    <box>
      {bind(activePlayer).as((player) => {
        if (!player) return <NoPlayerFound />;
        return <Player player={player} playerType={"widget"} />;
      })}
    </box>
  );
}
