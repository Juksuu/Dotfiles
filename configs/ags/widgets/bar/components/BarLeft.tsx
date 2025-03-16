import { App } from "astal/gtk3";
import {
  HYPRLAND,
  settingsVisibility,
  userPanelVisibility,
} from "../../../variables";
import ToggleButton from "./ToggleButton";
import { bind, Variable } from "astal";

export default function BarLeft() {
  function Workspaces() {
    let previousWorkspace: number = 0; // Variable to store the previous workspace ID

    // Add the "." icon for empty workspaces
    // const workspaceToIcon = [
    //   "󰻃",
    //   "",
    //   "",
    //   "",
    //   "",
    //   "",
    //   "󰙯",
    //   "󰓓",
    //   "",
    //   "",
    //   "",
    // ];

    const focusedIcon = "󰻃";
    const emptyIcon = ""; // Icon for empty workspaces
    const extraWorkspaceIcon = ""; // Icon for workspaces beyond the maximum limit
    const maxWorkspaces = 10; // Maximum number of workspaces to display with custom icons

    const workspaces = Variable.derive(
      [
        // bind(newAppWorkspace, "value"),
        bind(HYPRLAND, "workspaces"),
        bind(HYPRLAND, "focusedWorkspace").as((w) => w.id),
      ],
      (workspaces, currentWorkspace) => {
        // print("workspaces", workspaces.length);
        // print("currentWorkspace", currentWorkspace);

        // Get the IDs of active workspaces and fill in empty slots
        const workspaceIds = workspaces.map((w) => w.id);
        const totalWorkspaces = Math.max(workspaceIds.length, maxWorkspaces);
        const allWorkspaces = Array.from(
          { length: totalWorkspaces },
          (_, i) => i + 1,
        ); // Create all workspace slots from 1 to totalWorkspaces

        let inActiveGroup = false; // Flag to track if we're in an active group
        let previousWorkspace_ = currentWorkspace; // Store the previous workspace ID

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
              // Workspace has changed, mark it as `focused`
              class_names.push("focused");
            } else {
              // Same workspace remains focused, mark it as `same-focused`
              class_names.push("same-focused");
            }
            previousWorkspace_ = currentWorkspace;
          }

          // Handle active groups
          if (isActive) {
            if (!inActiveGroup) {
              if (workspaceIds.includes(id + 1)) {
                class_names.push("first");
                inActiveGroup = true; // Set the flag to indicate we're in an active group
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
                // print(`dispatch workspace ${id}`);
                HYPRLAND.message_async(`dispatch workspace ${id}`);
              }}
            />
          );
        });

        // results.unshift(
        //   <button
        //     className="special"
        //     label={workspaceToIcon[0]}
        //     onClicked={
        //       () =>
        //         Hyprland.message_async(
        //           `dispatch togglespecialworkspace`,
        //           (res) => print(res),
        //         )
        //       // .catch((err) => print(err))
        //     }
        //   />,
        // );

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
        onToggled={(self, on) => App.toggle_window("app-launcher")}
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
