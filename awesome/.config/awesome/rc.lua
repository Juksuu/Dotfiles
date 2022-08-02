-- awesome_mode: api-level=4:screen=on
-- If LuaRocks is installed, make sure that packages installed through it are
-- found (e.g. lgi). If LuaRocks is not installed, do nothing.
pcall(require, "luarocks.loader")

-- Standard awesome library
local awful = require("awful")
local beautiful = require("beautiful")
local naughty = require("naughty")

require("awful.autofocus")

-- {{{
-- Error handling

-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
naughty.connect_signal("request::display_error", function(message, startup)
    naughty.notification({
        urgency = "critical",
        title = "Oops, an error happened" .. (startup and " during startup!" or "!"),
        message = message,
    })
end)

-- }}}

-- Themes define colours, icons, font and wallpapers.
beautiful.init("~/.config/awesome/themes/default.lua")

-- {{{
-- Tag layout

-- Table of layouts to cover with awful.layout.inc, order matters.
tag.connect_signal("request::default_layouts", function()
    awful.layout.append_default_layouts({
        awful.layout.suit.tile.left,
        awful.layout.suit.tile,
        awful.layout.suit.floating,
    })
end)

-- }}}

-- Notifications
naughty.connect_signal("request::display", function(n)
    naughty.layout.box({
        notification = n,
    })
end)

-- Enable sloppy focus, so that focus follows mouse.
client.connect_signal("mouse::enter", function(c)
    c:activate({
        context = "mouse_enter",
        raise = false,
    })
end)

-- Load bindings
require("binds")

-- Load rules
require("rules")

-- Load screen stuff
require("screens")

-- Autostart applications
awful.spawn.with_shell("~/.config/awesome/autostart.sh")
