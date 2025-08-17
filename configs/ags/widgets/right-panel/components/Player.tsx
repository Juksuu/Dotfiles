import Mpris from "gi://AstalMpris";
import { Gtk } from "ags/gtk3";
import { createBinding, createComputed } from "ags";
import { rightPanelWidth } from "../../../variables";
import { getDominantImageColor } from "../../../utils/color";

function lengthStr(length: number) {
  const min = Math.floor(length / 60);
  const sec = Math.floor(length % 60);
  const sec0 = sec < 10 ? "0" : "";
  return `${min}:${sec0}${sec}`;
}

const PLAY_ICON = "media-playback-start";
const PAUSE_ICON = "media-playback-pause";
const PREV_ICON = "media-skip-backward";
const NEXT_ICON = "media-skip-forward";

type Props = {
  player: Mpris.Player;
  playerType: "popup" | "widget";
};

export function Player({ player, playerType }: Props) {
  function Image() {
    if (playerType === "widget") return <box />;

    const customCss = createBinding(player, "coverArt").as((art) => {
      return `
        background-image: url('${art}');
        box-shadow: 0 0 5px 0 ${getDominantImageColor(art)};
      `;
    });
    return (
      <box valign={Gtk.Align.CENTER}>
        <box class={"img"} css={customCss}></box>
      </box>
    );
  }

  function Artist() {
    const text = createBinding(player, "artist").as((a) => a || "");
    return <label class={"artist"} maxWidthChars={20} truncate label={text} />;
  }

  function Title() {
    const text = createBinding(player, "title").as((a) => a || "Unknown Track");
    return <label class={"title"} maxWidthChars={20} truncate label={text} />;
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
        class={"slider"}
        // css={customCss}
        onDragged={({ value }) => {
          player.position = value * player.length;
        }}
        visible={createBinding(player, "length").as((l) => l > 0)}
        value={createBinding(player, "position").as((p) =>
          player.length > 0 ? p / player.length : 0,
        )}
      />
    );
  }

  function PositionLabel() {
    return (
      <label
        class={"position"}
        visible={createBinding(player, "position").as((l) => l > 0)}
        label={createBinding(player, "position").as(lengthStr)}
      />
    );
  }

  function Actions() {
    const playPauseVisible = createComputed(
      [createBinding(player, "can_play"), createBinding(player, "can_pause")],
      (play, pause) => play || pause,
    );

    const playPauseIcon = createBinding(player, "playback_status").as((s) => {
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
          visible={createBinding(player, "can_go_previous")}
        >
          <icon icon={PREV_ICON} />
        </button>
        <button
          onClicked={() => player.play_pause()}
          visible={playPauseVisible}
        >
          <icon icon={playPauseIcon} />
        </button>
        <button
          onClicked={() => player.next()}
          visible={createBinding(player, "can_go_next")}
        >
          <icon icon={NEXT_ICON} />
        </button>
      </box>
    );
  }

  function LengthLabel() {
    return (
      <label
        class={"length"}
        visible={createBinding(player, "length").as((l) => l > 0)}
        label={createBinding(player, "length").as(lengthStr)}
      />
    );
  }

  const customCss = createComputed(
    [createBinding(player, "coverArt"), rightPanelWidth],
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
    <box class={`player ${playerType}`} css={customCss} vexpand>
      <Image />
      <box spacing={5} vertical hexpand>
        <Artist />
        <box vexpand />
        <Title />
        <PositionSlider />
        <centerbox
          spacing={5}
          startWidget={PositionLabel() as Gtk.Widget}
          centerWidget={Actions() as Gtk.Widget}
          endWidget={LengthLabel() as Gtk.Widget}
        />
      </box>
    </box>
  );
}
