import { bind } from "astal";
import { Gtk } from "astal/gtk3";
import { DrawingArea } from "astal/gtk3/widget";
import Hyprland from "gi://AstalHyprland";
import Pango from "gi://Pango";
import PangoCairo from "gi://PangoCairo";
import Cairo from "cairo";
import Gdk from "gi://Gdk?version=3.0";

export default function Workspaces() {
    const hyprland = Hyprland.get_default();

    const dummyWs = <box className={'bar-ws'} />; // Not shown. Only for getting size props
    const dummyActiveWs = <box className={'bar-ws bar-ws-active'} />; // Not shown. Only for getting size props
    const dummyOccupiedWs = <box className={'bar-ws bar-ws-occupied'} />; // Not shown. Only for getting size props

    const workspacesShown = 10;

    let workspaceMask = 0;
    let workspaceGroup = 0;

    function updateMask(area: DrawingArea, count: number) {
        const workspace = hyprland.get_focused_workspace();

        const offset = Math.floor((workspace.id - 1) / count) * workspacesShown;

        let wsMask = 0;
        for (const ws of hyprland.get_workspaces()) {
            if (ws.id <= offset || ws.id > offset + count) continue; // Out of range, ignore
            if (ws.clients.length > 0) {
                wsMask |= (1 << (ws.id - offset));
            }
        }

        workspaceMask = wsMask;
        area.queue_draw();
    }

    function getFontWeightName(weight: Pango.Weight) {
        switch (weight) {
            case Pango.Weight.ULTRALIGHT:
                return 'UltraLight';
            case Pango.Weight.LIGHT:
                return 'Light';
            case Pango.Weight.NORMAL:
                return 'Normal';
            case Pango.Weight.BOLD:
                return 'Bold';
            case Pango.Weight.ULTRABOLD:
                return 'UltraBold';
            case Pango.Weight.HEAVY:
                return 'Heavy';
            default:
                return 'Normal';
        }
    }

    const mix = (v1: number, v2: number, p: number) => {
        return v1 * p + v2 * (1 - p);
    }

    function onFocusedWorkspace(self: DrawingArea, count: number) {
        const workspace = hyprland.get_focused_workspace();
        self.set_css(`font-size: ${(workspace.id - 1) % count + 1}px;`);

        const previousGroup = workspaceGroup;
        const currentGroup = Math.floor((workspace.id - 1) / count);

        if (currentGroup !== previousGroup) {
            updateMask(self, count);
            workspaceGroup = currentGroup;
        }
    }

    const WorkspaceContents = (count = 10) => {
        return <DrawingArea
            className={"bar-ws-container"}
            setup={self => {
                onFocusedWorkspace(self, count);
                self.hook(bind(hyprland, 'focused_workspace'), (self) => { onFocusedWorkspace(self, count) })
                self.hook(bind(hyprland, "workspaces"), (self) => {
                    updateMask(self, count);
                })
            }}
            // @ts-ignore // for some reason the types are wrong here
            onDraw={(self: DrawingArea, cr: Cairo.Context) => {
                const workspace = hyprland.get_focused_workspace();
                const offset = Math.floor((workspace.id - 1) / count) * workspacesShown;

                const { height } = self.get_allocation();

                const wsStyleContext = dummyWs.get_style_context();
                const occupiedWsStyleContext = dummyOccupiedWs.get_style_context();
                const activeWsStyleContext = dummyActiveWs.get_style_context();

                const wsfg = wsStyleContext.get_property('color', Gtk.StateFlags.NORMAL) as Gdk.RGBA;
                const wsDiameter = wsStyleContext.get_property('min-width', Gtk.StateFlags.NORMAL) as number;
                const wsFontSize = wsStyleContext.get_property('font-size', Gtk.StateFlags.NORMAL) as any;
                const wsFontFamily = wsStyleContext.get_property('font-family', Gtk.StateFlags.NORMAL) as any;
                const wsFontWeight = wsStyleContext.get_property('font-weight', Gtk.StateFlags.NORMAL) as any;

                const occupiedWsfg = occupiedWsStyleContext.get_property('color', Gtk.StateFlags.NORMAL) as any;
                const occupiedWsbg = occupiedWsStyleContext.get_property('background-color', Gtk.StateFlags.NORMAL) as any;

                const activeWsfg = activeWsStyleContext.get_property('color', Gtk.StateFlags.NORMAL) as any;
                const activeWsbg = activeWsStyleContext.get_property('background-color', Gtk.StateFlags.NORMAL) as any;

                self.set_size_request(wsDiameter * count, - 1);

                const widgetStyleContext = self.get_style_context();
                const activeWs = widgetStyleContext.get_property('font-size', Gtk.StateFlags.NORMAL) as any;

                const activeWsCenter = [
                    -(wsDiameter / 2) + (wsDiameter * activeWs),
                    height / 2
                ];

                const wsRadius = wsDiameter / 2;

                // Font
                const layout = PangoCairo.create_layout(cr)
                const fontDesc = Pango.font_description_from_string(
                    `${wsFontFamily[0]} ${getFontWeightName(wsFontWeight)} ${wsFontSize}`)

                cr.setAntialias(Cairo.Antialias.BEST);

                layout.set_font_description(fontDesc);
                layout.set_text("0".repeat(count.toString().length), -1);


                const [layoutWidth, layoutHeight] = layout.get_pixel_size();
                const indicatorRadius = Math.max(layoutWidth, layoutHeight) / 2;

                for (let i = 1; i <= count; i++) {
                    if (workspaceMask & (1 << i)) {
                        cr.setSourceRGBA(occupiedWsbg.red, occupiedWsbg.green, occupiedWsbg.blue, occupiedWsbg.alpha);

                        const wsCenter = [
                            -(wsRadius) + (wsDiameter * i),
                            height / 2,
                        ];

                        if (!(workspaceMask & (1 << (i - 1)))) { // Left
                            cr.arc(wsCenter[0], wsCenter[1], wsRadius, 0.5 * Math.PI, 1.5 * Math.PI);
                            cr.fill();
                        } else {
                            cr.rectangle(wsCenter[0] - wsRadius, wsCenter[1] - wsRadius, wsRadius, wsRadius * 2);
                            cr.fill();
                        }

                        if (!(workspaceMask & (1 << (i + 1)))) { // Right
                            cr.arc(wsCenter[0], wsCenter[1], wsRadius, -0.5 * Math.PI, 0.5 * Math.PI);
                            cr.fill();
                        } else {
                            cr.rectangle(wsCenter[0], wsCenter[1] - wsRadius, wsRadius, wsRadius * 2);
                            cr.fill();
                        }
                    }
                }

                // Draw active ws
                cr.setSourceRGBA(activeWsbg.red, activeWsbg.green, activeWsbg.blue, activeWsbg.alpha);
                cr.arc(activeWsCenter[0], activeWsCenter[1], indicatorRadius, 0, 2 * Math.PI);
                cr.fill();


                // Draw workspace numbers
                for (let i = 1; i <= count; i++) {
                    const inactivecolors = workspaceMask & (1 << i) ? occupiedWsfg : wsfg;

                    if (i === activeWs) {
                        cr.setSourceRGBA(activeWsfg.red, activeWsfg.green, activeWsfg.blue, activeWsfg.alpha);
                    } else if (
                        (i === Math.floor(activeWs) && workspace.id < activeWs) ||
                        (i === Math.ceil(activeWs) && workspace.id > activeWs)
                    ) {
                        const red = mix(activeWsfg.red, inactivecolors.red, 1 - Math.abs(activeWs - 1));
                        const green = mix(activeWsfg.green, inactivecolors.green, 1 - Math.abs(activeWs - 1));
                        const blue = mix(activeWsfg.blue, inactivecolors.blue, 1 - Math.abs(activeWs - 1));
                        cr.setSourceRGBA(red, green, blue, activeWsfg.alpha);
                    } else if (
                        (i === Math.floor(activeWs) && workspace.id > activeWs) ||
                        (i === Math.ceil(activeWs) && workspace.id < activeWs)
                    ) {
                        const red = mix(activeWsfg.red, inactivecolors.red, 1 - Math.abs(activeWs - 1));
                        const green = mix(activeWsfg.green, inactivecolors.green, 1 - Math.abs(activeWs - 1));
                        const blue = mix(activeWsfg.blue, inactivecolors.blue, 1 - Math.abs(activeWs - 1));
                        cr.setSourceRGBA(red, green, blue, activeWsfg.alpha);
                    } else {
                        cr.setSourceRGBA(inactivecolors.red, inactivecolors.green, inactivecolors.blue, inactivecolors.alpha);
                    }

                    layout.set_text(`${i + offset}`, -1);
                    const [layoutWidth, layoutHeight] = layout.get_pixel_size();

                    const pos = [
                        -wsRadius + (wsDiameter * i) - (layoutWidth / 2),
                        (height - layoutHeight) / 2,
                    ];
                    cr.moveTo(pos[0], pos[1]);
                    PangoCairo.show_layout(cr, layout);
                }
            }}>
        </DrawingArea >
    }

    return <box homogeneous={true} className={"bar-group-margin"}>
        <box className={"bar-group bar-group-standalone bar-group-pad"} css={"min-width: 2px;"}>
            {WorkspaceContents()}
        </box>
    </box>
}
