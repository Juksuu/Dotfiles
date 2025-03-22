import { bind } from "astal";
import { App, Astal, Gdk, Gtk } from "astal/gtk3";
import {
  DEFAULT_MARGIN,
  RIGHT_PANEL_WIDGET_LIMIT,
  rightPanelExclusivity,
  rightPanelWidgets,
  rightPanelWidth,
} from "../../variables";
import ToggleButton from "../common/ToggleButton";
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
            <ToggleButton
              label={selector.icon}
              state={isActive}
              onToggled={(self, on) => {
                if (on) {
                  if (
                    rightPanelWidgets.get().length >= RIGHT_PANEL_WIDGET_LIMIT
                  )
                    return;
                  if (!selector.widgetInstance) {
                    selector.widgetInstance = selector.widget();
                  }
                  rightPanelWidgets.set([...rightPanelWidgets.get(), selector]);
                } else {
                  const newWidgets = rightPanelWidgets
                    .get()
                    .filter((w) => w !== selector);
                  rightPanelWidgets.set(newWidgets);
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
          className={"expand-window"}
          onClicked={() => {
            rightPanelWidth.set(
              rightPanelWidth.get() < maxRightPanelWidth
                ? rightPanelWidth.get() + 50
                : maxRightPanelWidth,
            );
          }}
        />
        <button
          label={""}
          className={"shrink-window"}
          onClicked={() => {
            rightPanelWidth.set(
              rightPanelWidth.get() > minRightPanelWidth
                ? rightPanelWidth.get() - 50
                : minRightPanelWidth,
            );
          }}
        />
        <ToggleButton
          label={""}
          className={"exclusivity"}
          state={rightPanelExclusivity.get()}
          onToggled={(self, on) => {
            rightPanelExclusivity.set(on);
          }}
        />
        <button
          label={""}
          className={"close"}
          onClicked={() => {
            App.get_window(`rightpanel_${monitorIdentifier}`)?.hide();
          }}
        />
      </box>
    );
  }

  function Actions() {
    return (
      <box className={"right-panel-actions"} vertical>
        <WidgetActions />
        <WindowActions />
      </box>
    );
  }

  return (
    <window
      gdkmonitor={gdkMonitor}
      application={App}
      name={`rightpanel_${monitorIdentifier}`}
      className={bind(rightPanelExclusivity).as((exclusive) =>
        exclusive ? "right-panel exclusive" : "right-panel normal",
      )}
      anchor={
        Astal.WindowAnchor.RIGHT |
        Astal.WindowAnchor.TOP |
        Astal.WindowAnchor.BOTTOM
      }
      exclusivity={bind(rightPanelExclusivity).as((exclusive) =>
        exclusive ? Astal.Exclusivity.EXCLUSIVE : Astal.Exclusivity.NORMAL,
      )}
      layer={bind(rightPanelExclusivity).as((exclusive) =>
        exclusive ? Astal.Layer.BOTTOM : Astal.Layer.TOP,
      )}
      keymode={Astal.Keymode.ON_DEMAND}
      visible={false}
    >
      <box>
        <box
          className={"main-content"}
          css={bind(rightPanelWidth).as((width) => `*{min-width: ${width}px;}`)}
          spacing={10}
          vertical
        >
          {bind(rightPanelWidgets).as((widgets) => {
            return widgets.map((w) => {
              try {
                return w.widget();
              } catch (err) {
                print(`Error rendering widget ${w.name}`, err);
                return <box />;
              }
            });
          })}
        </box>
        <Actions />
      </box>
    </window>
  );
}
