import app from "ags/gtk3/app";
import { For } from "ags";
import { Astal, Gdk, Gtk } from "ags/gtk3";
import {
  RIGHT_PANEL_WIDGET_LIMIT,
  rightPanelExclusivity,
  rightPanelWidgets,
  rightPanelWidth,
  setRightPanelExclusivity,
  setRightPanelWidgets,
  setRightPanelWidth,
} from "../../variables";
import { WIDGET_SELECTORS } from "../../utils/right-panel-widgets";

const maxRightPanelWidth = 600;
const minRightPanelWidth = 200;

export default function RightPanel(
  gdkMonitor: Gdk.Monitor,
  monitorIdentifier: string,
) {
  const WidgetActions = () => {
    return (
      <box vertical vexpand>
        {WIDGET_SELECTORS.map((selector) => {
          const isActive = rightPanelWidgets
            .get()
            .some((w) => w.name === selector.name);
          return (
            <Gtk.ToggleButton
              label={selector.icon}
              active={isActive}
              onToggled={({ active }) => {
                if (active) {
                  if (
                    rightPanelWidgets.get().length < RIGHT_PANEL_WIDGET_LIMIT
                  ) {
                    setRightPanelWidgets([
                      ...rightPanelWidgets.get(),
                      selector,
                    ]);
                  }
                } else {
                  const newWidgets = rightPanelWidgets
                    .get()
                    .filter((w) => w.name !== selector.name);
                  setRightPanelWidgets(newWidgets);
                }
              }}
            />
          );
        })}
      </box>
    );
  };

  function WindowActions() {
    return (
      <box halign={Gtk.Align.END} valign={Gtk.Align.END} vertical vexpand>
        <button
          label={""}
          class={"expand-window"}
          onClicked={() => {
            setRightPanelWidth(
              rightPanelWidth.get() < maxRightPanelWidth
                ? rightPanelWidth.get() + 50
                : maxRightPanelWidth,
            );
          }}
        />
        <button
          label={""}
          class={"shrink-window"}
          onClicked={() => {
            setRightPanelWidth(
              rightPanelWidth.get() > minRightPanelWidth
                ? rightPanelWidth.get() - 50
                : minRightPanelWidth,
            );
          }}
        />
        <Gtk.ToggleButton
          label={""}
          class={"exclusivity"}
          active={rightPanelExclusivity.get()}
          onToggled={({ active }) => {
            setRightPanelExclusivity(active);
          }}
        />
        <button
          label={""}
          class={"close"}
          onClicked={() => {
            app.get_window(`rightpanel_${monitorIdentifier}`)?.hide();
          }}
        />
      </box>
    );
  }

  function Actions() {
    return (
      <box class={"right-panel-actions"} vertical>
        <WidgetActions />
        <WindowActions />
      </box>
    );
  }

  const widgets = rightPanelWidgets.as((widgets) => {
    return widgets.map((w) => {
      try {
        return w.widget();
      } catch (err) {
        print(`Error rendering widget ${w.name}`, err);
        return <box />;
      }
    });
  });

  return (
    <window
      namespace={"right-panel"}
      gdkmonitor={gdkMonitor}
      application={app}
      name={`rightpanel_${monitorIdentifier}`}
      class={rightPanelExclusivity.as((exclusive) =>
        exclusive ? "right-panel exclusive" : "right-panel normal",
      )}
      anchor={
        Astal.WindowAnchor.RIGHT |
        Astal.WindowAnchor.TOP |
        Astal.WindowAnchor.BOTTOM
      }
      exclusivity={rightPanelExclusivity.as((exclusive) =>
        exclusive ? Astal.Exclusivity.EXCLUSIVE : Astal.Exclusivity.NORMAL,
      )}
      layer={rightPanelExclusivity.as((exclusive) =>
        exclusive ? Astal.Layer.BOTTOM : Astal.Layer.TOP,
      )}
      keymode={Astal.Keymode.ON_DEMAND}
      visible={false}
    >
      <box>
        <box
          class={"main-content"}
          css={rightPanelWidth.as((width) => `*{min-width: ${width}px;}`)}
          spacing={10}
          vertical
        >
          <For each={widgets}>{(widget) => widget}</For>
        </box>
        <Actions />
      </box>
    </window>
  );
}
