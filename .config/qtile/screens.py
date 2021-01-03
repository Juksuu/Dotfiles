# -*- coding: utf-8 -*-
import re
import subprocess
from libqtile.config import Screen
from libqtile import bar, widget

class Screens():
    screens = []
    resolution_delimiters = "x", "+"
    cmd = "xrandr | grep -v disconnected | grep connected"

    colors = {}

    widgets_primary = []
    widgets_secondary = []

    def __init__(self, colorDefinitions):
        self.colors = colorDefinitions
        self.init_widgets()

        output = self.get_screen_info()
        parsed_screen_info = self.parse_screen_info(output)
        self.init_screens(parsed_screen_info)


    def init_screens(self, parsed_screen_info):
        for screen_info in parsed_screen_info:
            resolution = screen_info["resolution"]
            self.screens.append(
                Screen(
                    top=bar.Bar(widgets=self.screen_widgets(screen_info["name"]), opacity=1.0, size=20, margin=[0, 0, 0, 0], background=self.colors["bg"])
                ))

    def screen_widgets(self, screen_name):
        if screen_name == "DP-2":
            return self.widgets_primary
        else:
            return self.widgets_secondary

    def get_screen_info(self):
        p = subprocess.Popen(self.cmd, shell=True, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
        output = p.stdout.readlines()
        return output

    def parse_screen_info(self, output):
        parsed_screen_info = []
        for i, line in enumerate(output):
            string_line = str(line)
            split_info = string_line[2:].split(" ")

            resolutionIndex = (0, i) [i >= 1]
            resolution = split_info[3 - resolutionIndex]

            regex_pattern = '|'.join(map(re.escape, self.resolution_delimiters))
            resolution_parsed = re.split(regex_pattern, resolution)
            parsed_screen_info.append({
                "name": split_info[0],
                "resolution": resolution_parsed
            })
        return parsed_screen_info

    def init_widgets(self):
        widget_defaults = {
            "font": 'JetBrainsMono Nerd Font',
            "fontsize": 10
        }

        self.widgets_primary.extend([
            widget.Sep(
                **widget_defaults,
                linewidth = 0,
                padding = 6
            ),
            widget.GroupBox(
                **widget_defaults,
                margin_y = 4,
                padding_y = 4,
                borderwidth = 1,
                active = self.colors["accent"],
                inactive = self.colors["accent"],
                rounded = False,
                highlight_color = self.colors["shadow"],
                highlight_method = "line",
                this_current_screen_border = self.colors["accent"],
                this_screen_border = self.colors["accent"],
                # other_current_screen_border = colors[0],
                # other_screen_border = colors[0],
                foreground = self.colors["fg"]
            ),
            widget.Sep(
                **widget_defaults,
                linewidth = 0,
                padding = 20
            ),
            widget.WindowName(
                **widget_defaults,
                foreground = self.colors["fg"]
            ),
            widget.ThermalSensor(
                **widget_defaults,
                threshold = 80,
                foreground = self.colors["string"],
                foreground_alert = self.colors["error"]
            ),
            widget.Sep(
                **widget_defaults,
                padding = 10,
                foreground = self.colors["fg"]
            ),
            widget.CurrentLayout(
                **widget_defaults,
                foreground = self.colors["fg"]
            ),
            widget.Sep(
                **widget_defaults,
                padding = 10,
                foreground = self.colors["fg"]
            ),
            widget.Clock(
                **widget_defaults,
                format = "%A, %B %d %H:%M",
                foreground = self.colors["string"]
            ),
            widget.Sep(
                **widget_defaults,
                padding = 10,
                foreground = self.colors["fg"]
            ),
            widget.Systray(
                **widget_defaults,
            )
        ])

        self.widgets_secondary.extend([
            widget.Sep(
                **widget_defaults,
                linewidth = 0,
                padding = 6
            ),
            widget.GroupBox(
                **widget_defaults,
                margin_y = 4,
                padding_y = 4,
                borderwidth = 1,
                active = self.colors["accent"],
                inactive = self.colors["accent"],
                rounded = False,
                highlight_color = self.colors["shadow"],
                highlight_method = "line",
                this_current_screen_border = self.colors["accent"],
                this_screen_border = self.colors["accent"],
                # other_current_screen_border = colors[0],
                # other_screen_border = colors[0],
                foreground = self.colors["fg"]
            ),
            widget.Sep(
                **widget_defaults,
                linewidth = 0,
                padding = 20
            ),
            widget.WindowName(
                **widget_defaults,
                foreground = self.colors["fg"]
            ),
            widget.ThermalSensor(
                **widget_defaults,
                threshold = 80,
                foreground = self.colors["string"],
                foreground_alert = self.colors["error"]
            ),
            widget.Sep(
                **widget_defaults,
                padding = 10,
                foreground = self.colors["fg"]
            ),
            widget.CurrentLayout(
                **widget_defaults,
                foreground = self.colors["fg"]
            ),
            widget.Sep(
                **widget_defaults,
                padding = 10,
                foreground = self.colors["fg"]
            ),
            widget.Clock(
                **widget_defaults,
                format = "%A, %B %d %H:%M",
                foreground = self.colors["string"]
            )
        ])


