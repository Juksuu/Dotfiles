import { Gtk, Widget } from "astal/gtk3";
import { Button, Icon, Revealer } from "astal/gtk3/widget";
import { CONFIG } from "../../bar/config";
import Apps from "gi://AstalApps";
import { GObject } from "astal";

type SearchItemProps = {
  actionName: string;
  onClick: () => void;
  extraClassNames?: string;
  app?: Apps.Application;
  custom?: {
    name: string;
    content: string;
    materialIconName: string;
  };
};

type SearchItemButtonProps = Widget.ButtonProps & {
  clickCb?: () => void;
};

export class SearchItemButton extends Button {
  private props?: SearchItemButtonProps;

  static {
    GObject.registerClass({ GTypeName: "SearchItemButton" }, this);
  }

  constructor(props?: SearchItemButtonProps, child?: any) {
    super(props, child);

    this.props = props;
  }

  public triggerClickCb(): void {
    if (this.props?.clickCb) {
      this.props.clickCb();
    }
  }
}

export default function SearchItem(props: SearchItemProps) {
  const actionText = (
    <Revealer
      transitionType={Gtk.RevealerTransitionType.CROSSFADE}
      transitionDuration={CONFIG.animations.durationLarge}
      revealChild={false}
    >
      <label
        className={"overview-search-results-txt txt-size-12 txt-action txt"}
        label={props.actionName}
      ></label>
    </Revealer>
  );

  const actionTextRevealer = (
    <Revealer
      transitionType={Gtk.RevealerTransitionType.SLIDE_LEFT}
      transitionDuration={CONFIG.animations.durationSmall}
      revealChild={false}
    >
      {actionText}
    </Revealer>
  );

  return (
    <SearchItemButton
      className={`overview-search-results-btn txt ${props.extraClassNames}`}
      onClick={props.onClick}
      clickCb={props.onClick}
      setup={(self) => {
        self.connect("focus-in-event", () => {
          (actionText as Revealer).revealChild = true;
          (actionTextRevealer as Revealer).revealChild = true;
        });
        self.connect("focus-out-event", () => {
          (actionText as Revealer).revealChild = false;
          (actionTextRevealer as Revealer).revealChild = false;
        });
      }}
    >
      <box>
        <box vertical={true}>
          {props.app ? (
            <box className={"overview-search-results-icon"} homogeneous={true}>
              <Icon icon={props.app.iconName}></Icon>
            </box>
          ) : (
            <label
              className={"icon-material overview-search-results-icon"}
              label={props.custom?.materialIconName}
            ></label>
          )}
          {props.app ? (
            <label
              className={"overview-search-results-txt txt-size-16 txt"}
              label={props.app.name}
            ></label>
          ) : (
            <box vertical={true}>
              <label
                className={
                  "overview-search-results-txt txt-size-11 txt-subtext"
                }
                halign={Gtk.Align.START}
                truncate={true}
                label={props.custom?.name}
              ></label>
              <label
                className={"overview-search-results-txt txt-size-12"}
                halign={Gtk.Align.START}
                truncate={true}
                label={props.custom?.content}
              ></label>
            </box>
          )}
          <box hexpand={true}></box>
          {actionTextRevealer}
        </box>
      </box>
    </SearchItemButton>
  );
}
