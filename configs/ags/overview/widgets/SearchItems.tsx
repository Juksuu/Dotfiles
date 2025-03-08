import { App } from "astal/gtk3";
import Apps from "gi://AstalApps";
import SearchItem from "./SearchItem";

export function DesktopEntryButton(app: Apps.Application) {
  console.log("app name", app.name);

  return SearchItem({
    actionName: "Launch",
    onClick: () => {
      App.get_window("overview")?.hide();
      app.launch();
    },
    app,
  });
}

export function NoResultButton() {
  return SearchItem({
    actionName: "",
    onClick: () => {
      App.get_window("overview")?.hide();
    },
    custom: {
      name: "Search invalid",
      content: "No results found!",
      materialIconName: "Error",
    },
  });
}
