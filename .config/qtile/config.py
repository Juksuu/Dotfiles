# -*- coding: utf-8 -*-
import os
import re
import socket
import subprocess

from typing import List
from libqtile import layout, hook
from libqtile.config import Group
from libqtile.lazy import lazy

from screens import Screens
from keys import Keys

## Startup programs ##
@hook.subscribe.startup_once
def start_once():
    home = os.path.expanduser('~')
    subprocess.call([home + '/.config/qtile/autostart.sh'])

## Floating transient clients ##
@hook.subscribe.client_new
def transient_window(window):
	if window.window.get_wm_transient_for():
		window.floating = True

## Restart on screen change ##
@hook.subscribe.screen_change
def restart_on_randr(qtile, ev):
	qtile.cmd_restart()

## Initialization ##
if __name__ in ["config", "__main__"]:

    # Screen initialization
    screens_class = Screens()
    extension_defaults = screens_class.widget_defaults.copy()
    screens = screens_class.screens

    # Groups initialization
    groups = [Group(i) for i in "asdfuiop"]

    # Keys initialization
    key_class = Keys(groups)
    keys = Keys.keys
    mouse = Keys.mouse


    # Layouts
    layouts = [
        layout.MonadTall(),
        # layout.Max(),
        # layout.Stack(num_stacks=2),
        # layout.Bsp(),
        # layout.Columns(),
        # layout.Matrix(),
        # layout.MonadWide(),
        # layout.RatioTile(),
        # layout.Tile(),
        # layout.TreeTab(),
        # layout.VerticalTile(),
        # layout.Zoomy(),
    ]
    floating_layout = layout.Floating(float_rules=[
        # Run the utility of `xprop` to see the wm class and name of an X client.
        {'wmclass': 'confirm'},
        {'wmclass': 'dialog'},
        {'wmclass': 'download'},
        {'wmclass': 'error'},
        {'wmclass': 'file_progress'},
        {'wmclass': 'notification'},
        {'wmclass': 'splash'},
        {'wmclass': 'toolbar'},
        {'wmclass': 'confirmreset'},  # gitk
        {'wmclass': 'makebranch'},  # gitk
        {'wmclass': 'maketag'},  # gitk
        {'wname': 'branchdialog'},  # gitk
        {'wname': 'pinentry'},  # GPG key password entry
        {'wmclass': 'ssh-askpass'},  # ssh-askpass
    ])

    # Constants
    wmname = "LG3D"
    cursor_warp = False
    auto_fullscreen = True
    dgroups_app_rules = []
    dgroups_key_binder = None
    follow_mouse_focus = True
    bring_front_click = False
    focus_on_window_activation = "smart"
