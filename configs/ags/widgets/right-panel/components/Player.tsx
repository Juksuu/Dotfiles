import { bind, Variable } from "astal";
import { rightPanelWidth } from "../../../variables";
import { Gtk } from "astal/gtk3";
import { getDominantImageColor } from "../../../utils/color";
import Mpris from "gi://AstalMpris";

function lengthStr(length: number) {
  const min = Math.floor(length / 60);
  const sec = Math.floor(length % 60);
  const sec0 = sec < 10 ? "0" : "";
  return `${min}:${sec0}${sec}`;
}

const PLAY_ICON = "media-playback-start-symbolic";
const PAUSE_ICON = "media-playback-pause-symbolic";
const PREV_ICON = "media-skip-backward-symbolic";
const NEXT_ICON = "media-skip-forward-symbolic";

type Props = {
  player: Mpris.Player;
  playerType: "popup" | "widget";
};

export function Player({ player, playerType }: Props) {
  function Image() {
    if (playerType === "widget") return <box />;

    const customCss = bind(player, "coverArt").as((art) => {
      return `
        background-image: url('${art}');
        box-shadow: 0 0 5px 0 ${getDominantImageColor(art)};
      `;
    });
    return (
      <box valign={Gtk.Align.CENTER}>
        <box className={"img"} css={customCss}></box>
      </box>
    );
  }

  function Artist() {
    const text = bind(player, "artist").as((a) => a || "");
    return (
      <label className={"artist"} maxWidthChars={20} truncate label={text} />
    );
  }

  function Title() {
    const text = bind(player, "title").as((a) => a || "Unknown Track");
    return (
      <label className={"title"} maxWidthChars={20} truncate label={text} />
    );
  }

  function PositionSlider() {
    // TODO: Fix customCss selectors
    // const customCss = bind(player, "coverArt").as((art) => {
    //   return art
    //     ? `
    //     .highlight {
    //       background: ${getDominantImageColor(art)}00};
    //     }
    //   `
    //     : "";
    // });

    return (
      <slider
        className={"slider"}
        // css={customCss}
        onDragged={({ value }) => {
          player.position = value * player.length;
        }}
        visible={bind(player, "length").as((l) => l > 0)}
        value={bind(player, "position").as((p) =>
          player.length > 0 ? p / player.length : 0,
        )}
      />
    );
  }

  function PositionLabel() {
    return (
      <label
        className={"position"}
        visible={bind(player, "position").as((l) => l > 0)}
        label={bind(player, "position").as(lengthStr)}
      />
    );
  }

  function Actions() {
    const playPauseVisible = Variable.derive(
      [bind(player, "can_play"), bind(player, "can_pause")],
      (play, pause) => play || pause,
    );

    const playPauseIcon = bind(player, "playback_status").as((s) => {
      switch (s) {
        case Mpris.PlaybackStatus.PLAYING:
          return PAUSE_ICON;
        case Mpris.PlaybackStatus.PAUSED:
        case Mpris.PlaybackStatus.STOPPED:
          return PLAY_ICON;
      }
    });

    return (
      <box>
        <button
          onClicked={() => player.previous()}
          visible={bind(player, "can_go_previous")}
        >
          <icon icon={PREV_ICON} />
        </button>
        <button
          onClicked={() => player.play_pause()}
          visible={bind(playPauseVisible)}
        >
          <icon icon={playPauseIcon} />
        </button>
        <button
          onClicked={() => player.next()}
          visible={bind(player, "can_go_next")}
        >
          <icon icon={NEXT_ICON} />
        </button>
      </box>
    );
  }

  function LengthLabel() {
    return (
      <label
        className={"length"}
        visible={bind(player, "length").as((l) => l > 0)}
        label={bind(player, "length").as(lengthStr)}
      />
    );
  }

  const customCss = Variable.derive(
    [bind(player, "coverArt"), bind(rightPanelWidth)],
    (art, width) => {
      return playerType == "widget"
        ? `
           min-height: ${width}px;
           background-image: url('${art}');
        `
        : ``;
    },
  );

  return (
    <box className={`player ${playerType}`} css={bind(customCss)} vexpand>
      <Image />
      <box spacing={5} vertical hexpand>
        <Artist />
        <box vexpand />
        <Title />
        <PositionSlider />
        <centerbox>
          <PositionLabel />
          <Actions />
          <LengthLabel />
        </centerbox>
      </box>
    </box>
  );
}
