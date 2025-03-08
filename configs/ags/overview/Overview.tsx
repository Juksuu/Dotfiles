import { App, Astal, Gtk } from "astal/gtk3";
import PopupWindow from "../common/widgets/PopupWindow";
import { Entry, Revealer, Box } from "astal/gtk3/widget";
import { CONFIG } from "../bar/config";
import Apps from "gi://AstalApps";
import { DesktopEntryButton, NoResultButton } from "./widgets/SearchItems";
import { bind } from "astal";
import { SearchItemButton } from "./widgets/SearchItem";
import ClickCloseRegion from "../common/widgets/ClickCloseRegion";

const MAX_RESULTS = 10;

export default function Overview() {
  const { TOP } = Astal.WindowAnchor;

  const apps = new Apps.Apps();

  let appSearchResults: Apps.Application[] = [];

  const handleSelection = (_entry: Entry) => {
    console.log("select");
    ((resultsBox as Box).children[0] as SearchItemButton).triggerClickCb();
  };

  const handleInputUpdate = (entry: Entry) => {
    (resultsBox as Box).children.forEach((ch) => ch.destroy());

    if (entry.text === "") {
      // overviewContent.revealChild = true;
      (resultsRevealer as Revealer).revealChild = false;
      (entryPromptRevealer as Revealer).revealChild = true;
      (entryIconRevealer as Revealer).revealChild = false;
      entry.toggleClassName("overview-search-box-extended", false);
      return;
    }

    // overviewContent.revealChild = false;
    (resultsRevealer as Revealer).revealChild = true;
    (entryPromptRevealer as Revealer).revealChild = false;
    (entryIconRevealer as Revealer).revealChild = true;
    entry.toggleClassName("overview-search-box-extended", true);

    appSearchResults = apps.fuzzy_query(entry.text);

    // Add application entries
    let appsToAdd = MAX_RESULTS;
    appSearchResults.forEach((app) => {
      if (appsToAdd === 0) return;
      (resultsBox as Box).add(DesktopEntryButton(app));
      appsToAdd--;
    });

    if ((resultsBox as Box).children.length == 0) {
      (resultsBox as Box).add(NoResultButton());
    }

    resultsBox.show_all();
  };

  const entryPromptRevealer = (
    <Revealer
      transitionType={Gtk.RevealerTransitionType.CROSSFADE}
      transitionDuration={CONFIG.animations.durationLarge}
      halign={Gtk.Align.CENTER}
      revealChild={true}
    >
      <label
        className={"overview-search-prompt txt-size-12 txt"}
        label={"Type to search"}
      ></label>
    </Revealer>
  );

  const entryIconRevealer = (
    <Revealer
      transitionType={Gtk.RevealerTransitionType.CROSSFADE}
      transitionDuration={CONFIG.animations.durationLarge}
      revealChild={false}
      halign={Gtk.Align.END}
    >
      <label
        className={"overview-search-icon icon-material txt-size-16 txt"}
        label={"search"}
      ></label>
    </Revealer>
  );

  const entryIcon = (
    <box
      className={"overview-search-prompt-box"}
      setup={(self) => {
        self.pack_start(entryIconRevealer, true, true, 0);
      }}
    ></box>
  );

  const resultsBox = (
    <box className={"overview-search-results"} vertical={true}></box>
  );

  const resultsRevealer = (
    <Revealer
      transitionType={Gtk.RevealerTransitionType.SLIDE_DOWN}
      transitionDuration={CONFIG.animations.durationLarge}
      revealChild={false}
      halign={Gtk.Align.CENTER}
    >
      {resultsBox}
    </Revealer>
  );

  const entry = (
    <Entry
      className={"overview-search-box txt-size-12 txt"}
      onActivate={handleSelection}
      onChanged={handleInputUpdate}
      halign={Gtk.Align.CENTER}
    ></Entry>
  );

  const elements = (
    <box
      vertical={true}
      setup={(self) => {
        self.hook(bind(App, "activeWindow"), (self) => {
          const active = App.active_window;
          if (active.name === "overview") {
            (resultsBox as Box).children = [];
            (entry as Entry).set_text("");
          }
        });
      }}
    >
      <box halign={Gtk.Align.CENTER}>
        {entry}
        <box
          className={"overview-search-icon-box"}
          setup={(self) => {
            self.pack_start(entryPromptRevealer, true, true, 0);
          }}
        ></box>
        {entryIcon}
      </box>
      {resultsRevealer}
    </box>
  );

  return (
    <PopupWindow name={"overview"} anchor={TOP}>
      {elements}
    </PopupWindow>
  );
}
