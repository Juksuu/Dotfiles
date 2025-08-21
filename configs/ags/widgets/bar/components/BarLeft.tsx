import app from "ags/gtk3/app";
import Hyprland from "gi://AstalHyprland";
import { Gtk } from "ags/gtk3";
import { execAsync } from "ags/process";
import { createBinding, createComputed, For } from "ags";

type Props = {
  monitorIdentifier: string;
};

export default function BarLeft({ monitorIdentifier }: Props) {
  function Workspaces() {
    const hyprland = Hyprland.get_default();

    let previousWorkspace = 0;

    const focusedIcon = "󰻃";
    const emptyIcon = "";
    const extraWorkspaceIcon = ""; // Icon for workspaces beyond the maximum limit
    const maxWorkspaces = 10;

    const workspaces = createComputed(
      [
        createBinding(hyprland, "workspaces"),
        createBinding(hyprland, "focusedWorkspace").as((w) => w.id),
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

          // TODO: Better solution for centering workspace icon correctly
          let horizontalAlignment = 0.5;

          if (isFocused) {
            if (previousWorkspace !== currentWorkspace) {
              class_names.push("focused");
            } else {
              class_names.push("same-focused");
            }
            previousWorkspace_ = currentWorkspace;
          }

          if (isActive) {
            if (isFocused) {
              horizontalAlignment = 0.42;
            }

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
              class={class_names.join(" ")}
              label={icon}
              xalign={horizontalAlignment}
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

    return (
      <box class={"workspaces"}>
        <For each={workspaces}>{(item) => item}</For>
      </box>
    );
  }

  function Settings() {
    return (
      <Gtk.ToggleButton
        class={"settings"}
        label={""}
        onToggled={() => app.toggle_window(`settings_${monitorIdentifier}`)}
      />
    );
  }

  function UserPanel() {
    return (
      <button
        class={"user-panel"}
        label={""}
        onButtonPressEvent={() => {
          execAsync("wlogout -p layer-shell");
        }}
      />
    );
  }

  function Actions() {
    return (
      <box class={"actions"}>
        <UserPanel />
        <Settings />
      </box>
    );
  }

  return (
    <box class={"bar-left"} spacing={5}>
      <Actions />
      <Workspaces />
    </box>
  );
}
