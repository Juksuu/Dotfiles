# -*- coding: utf-8 -*-

import re
import subprocess
from libqtile.config import Screen
from libqtile import bar, widget

class Screens():
    screens = []
    resolution_delimiters = "x", "+"
    cmd = "xrandr | grep -v disconnected | grep connected"

    widget_defaults = dict(
        font='JetBrainsMono Nerd Font',
        fontsize=14,
        padding=2
    )

    widgets_primary = [
        widget.CurrentLayout(),
        widget.GroupBox(),
        widget.Prompt(),
        widget.WindowName(),
        widget.Chord(
            chords_colors={
                'launch': ("#ff0000", "#ffffff"),
            },
            name_transform=lambda name: name.upper(),
        ),
        widget.TextBox("default config", name="default"),
        widget.TextBox("Press &lt;M-r&gt; to spawn", foreground="#d75f5f"),
        widget.Systray(),
        widget.Clock(format='%Y-%m-%d %a %I:%M %p'),
        widget.QuickExit()
    ]

    widgets_secondary = [
        widget.CurrentLayout(),
        widget.GroupBox(),
        widget.Prompt(),
        widget.WindowName(),
        widget.Chord(
            chords_colors={
                'launch': ("#ff0000", "#ffffff"),
            },
            name_transform=lambda name: name.upper(),
        ),
        widget.TextBox("default config", name="default"),
        widget.TextBox("Press &lt;M-r&gt; to spawn", foreground="#d75f5f"),
        widget.Systray(),
        widget.Clock(format='%Y-%m-%d %a %I:%M %p'),
        widget.QuickExit()
    ]

    def __init__(self):
        output = self.get_screen_info()
        parsed_screen_info = self.parse_screen_info(output)
        self.init_screens(parsed_screen_info)


    def init_screens(self, parsed_screen_info):
        for screen_info in parsed_screen_info:
            resolution = screen_info["resolution"]
            self.screens.append(
                Screen(
                    top=bar.Bar(widgets=self.screen_widgets(screen_info["name"]), opacity=1.0, size=20),
                    width=resolution[0],
                    height=resolution[1],
                    x=resolution[2],
                    y=resolution[3]
                ))

    def screen_widgets(self, screen_name):
        if screen_name == "DP-0":
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
