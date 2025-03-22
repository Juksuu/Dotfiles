import { App } from "astal/gtk3";
import { settingsVisibility, userPanelVisibility } from "../../../variables";
import { bind, Variable } from "astal";
import Hyprland from "gi://AstalHyprland";
import ToggleButton from "../../common/ToggleButton";

export default function BarLeft() {
  function Workspaces() {
    const hyprland = Hyprland.get_default();

    let previousWorkspace = 0;

    const focusedIcon = "󰻃";
    const emptyIcon = "";
    const extraWorkspaceIcon = ""; // Icon for workspaces beyond the maximum limit
    const maxWorkspaces = 10;

    const workspaces = Variable.derive(
      [
        bind(hyprland, "workspaces"),
        bind(hyprland, "focusedWorkspace").as((w) => w.id),
      ],
      (workspaces, currentWorkspace) => {
        const workspaceIds = workspaces.map((w) => w.id);
        const totalWorkspaces = Math.max(workspaceIds.length, maxWorkspaces);
        const allWorkspaces = Array.from(
          { length: totalWorkspaces },
          (_, i) => i + 1,
        );

        let inActiveGroup = false;
        let previousWorkspace_ = currentWorkspace;

        const results = allWorkspaces.map((id) => {
          const isFocused = currentWorkspace == id;
          const isActive = workspaceIds.includes(id);

          const icon =
            id > maxWorkspaces
              ? extraWorkspaceIcon
              : isActive && isFocused
                ? focusedIcon
                : emptyIcon;

          let class_names: string[] = ["button"]; // Default class names

          if (isFocused) {
            if (previousWorkspace !== currentWorkspace) {
              class_names.push("focused");
            } else {
              class_names.push("same-focused");
            }
            previousWorkspace_ = currentWorkspace;
          }

          if (isActive) {
            if (!inActiveGroup) {
              if (workspaceIds.includes(id + 1)) {
                class_names.push("first");
                inActiveGroup = true;
              } else {
                class_names.push("only");
              }
            } else {
              if (workspaceIds.includes(id + 1)) {
                class_names.push("between");
              } else {
                class_names.push("last");
                inActiveGroup = false;
              }
            }
          } else {
            class_names.push("inactive");
          }

          return (
            <button
              className={class_names.join(" ")}
              label={icon}
              onClicked={() => {
                hyprland.message(`dispatch workspace ${id}`);
              }}
            />
          );
        });

        previousWorkspace = previousWorkspace_;
        return results;
      },
    );

    return <box className={"workspaces"}>{bind(workspaces)}</box>;
  }

  function AppLauncher() {
    return (
      <ToggleButton
        className={"app-search"}
        label={""}
        onToggled={() => App.toggle_window("app-launcher")}
      />
    );
  }

  function Settings() {
    return (
      <ToggleButton
        className={"settings"}
        label={""}
        onToggled={(_, on) => settingsVisibility.set(on)}
      />
    );
  }

  function UserPanel() {
    return (
      <ToggleButton
        className={"user-panel"}
        label={""}
        onToggled={(_, on) => userPanelVisibility.set(on)}
      />
    );
  }

  function Actions() {
    return (
      <box className={"actions"}>
        <UserPanel />
        <Settings />
        <AppLauncher />
      </box>
    );
  }

  return (
    <box className={"bar-left"} spacing={5}>
      <Actions />
      <Workspaces />
    </box>
  );
}
