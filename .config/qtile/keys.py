# -*- coding: utf-8 -*-
from libqtile.config import Click, Drag, Key
from libqtile.lazy import lazy
from libqtile.utils import guess_terminal

class Keys():
    keys = []
    mouse = []

    # Key alias
    mod =   "mod4"
    alt =   "mod1"

    terminal = guess_terminal()

    def __init__(self, group_names):
        self.init_keys()
        self.init_mouse()
        self.init_group_binds(group_names)

    def init_keys(self):
        self.keys.extend([
            ### Essential keybinbds
            Key([self.mod], "Return", lazy.spawn(self.terminal),
                desc='Launches My Terminal'),

            Key([self.mod, "shift"], "Return", lazy.spawn("dmenu_run -fn 'Code New Roman-10'"),
                desc='Run Launcher'),

            Key([self.mod], "Tab", lazy.next_layout(),
                desc='Toggle through layouts'),

            Key([self.mod, "shift"], "c", lazy.window.kill(),
                desc='Kill active window'),

            Key([self.mod, "shift"], "r", lazy.restart(),
                desc='Restart Qtile'),

            Key([self.mod, "shift"], "q", lazy.shutdown(),
                desc='Shutdown Qtile'),


            ### Window controls
            Key([self.mod], "k", lazy.layout.down(),
                desc='Move focus down in current stack pane'),

            Key([self.mod], "j", lazy.layout.up(),
                desc='Move focus up in current stack pane'),

            Key([self.mod, "shift"], "k", lazy.layout.shuffle_down(),
                desc='Move windows down in current stack'),

            Key([self.mod, "shift"], "j", lazy.layout.shuffle_up(),
                desc='Move windows up in current stack'),

            Key([self.mod], "n", lazy.layout.normalize(),
                desc='normalize window size ratios'),

            Key([self.mod], "m", lazy.layout.maximize(),
                desc='toggle window between minimum and maximum sizes'),

            Key([self.mod, "shift"], "f", lazy.window.toggle_floating(),
                desc='toggle floating'),

            Key([self.mod, "shift"], "m", lazy.window.toggle_fullscreen(),
                desc='toggle fullscreen'),


            ### Switch focus to specific monitor
            Key([self.mod], "w", lazy.to_screen(0),
                desc='Keyboard focus to monitor 1'),

            Key([self.mod], "e", lazy.to_screen(1),
                desc='Keyboard focus to monitor 2'),

            ### Switch focus of monitors
            Key([self.mod], "period", lazy.next_screen(),
                desc='Move focus to next monitor'),

            Key([self.mod], "comma", lazy.prev_screen(),
                desc='Move focus to prev monitor'),
        ])

    def init_group_binds(self, group_names):
        for i, (name, kwargs) in enumerate(group_names, 1):
            self.keys.extend([
                Key([self.mod], str(i), lazy.group[name].toscreen()), # Switch to another group
                Key([self.mod, "shift"], str(i), lazy.window.togroup(name)) # Send current window to another group
            ])

    def init_mouse(self):
        self.mouse.extend([
            Drag([self.mod], "Button1", lazy.window.set_position_floating(),
                 start=lazy.window.get_position()),
            Drag([self.mod], "Button3", lazy.window.set_size_floating(),
                 start=lazy.window.get_size()),
            Click([self.mod], "Button2", lazy.window.bring_to_front())
        ])
