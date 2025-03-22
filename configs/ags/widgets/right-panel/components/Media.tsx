import { Gtk } from "astal/gtk3";
import Mpris from "gi://AstalMpris";
import { Player } from "./Player";

export default function Media() {
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

  function ActivePlayer() {
    const mpris = Mpris.get_default();

    if (mpris.players.length == 0) return <NoPlayerFound />;

    const player =
      mpris.players.find(
        (player) => player.playbackStatus === Mpris.PlaybackStatus.PLAYING,
      ) || mpris.players[0];

    return <Player player={player} playerType={"widget"} />;
  }

  return <ActivePlayer />;
}
