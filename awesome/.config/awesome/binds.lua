-- Enable hotkeys help widget for VIM and other apps
-- when client with a matching name is opened:
require("awful.hotkeys_popup.keys")

local awful = require("awful")
local variables = require("variables")
local hotkeys_popup = require("awful.hotkeys_popup")

-- Mouse bindings
local mouse_binds = {
    global = {
        { modifiers = {}, key = 4, run = awful.tag.viewprev },
        { modifiers = {}, key = 5, run = awful.tag.viewnext },
    },
    client = {
        {
            modifiers = {},
            key = 1,
            run = function(c)
                c:activate({ context = "mouse_click" })
            end,
        },
        {
            modifiers = { variables.modkey },
            key = 1,
            run = function(c)
                c:activate({ context = "mouse_click", action = "mouse_move" })
            end,
        },
        {
            modifiers = { variables.modkey },
            key = 3,
            run = function(c)
                c:activate({ context = "mouse_click", action = "mouse_resize" })
            end,
        },
    },
}

-- Keybindings
local keybinds = {
    global = {
        -- General
        {
            modifiers = { variables.modkey },
            key = "s",
            run = hotkeys_popup.show_help,
            desc = { description = "Show help", group = "Awesome: General" },
        },
        {
            modifiers = { variables.modkey, "Control" },
            key = "r",
            run = awesome.restart,
            desc = { description = "Restart awesome", group = "Awesome: General" },
        },
        {
            modifiers = { variables.modkey, "Shift" },
            key = "q",
            run = awesome.quit,
            desc = { description = "Quit awesome", group = "Awesome: General" },
        },
        {
            modifiers = { variables.modkey },
            key = "Return",
            run = function()
                awful.spawn(variables.terminal)
            end,
            desc = { description = "Open terminal", group = "Awesome: Launcher" },
        },
        {
            modifiers = { variables.modkey },
            key = "r",
            run = function()
                awful.spawn("rofi -show drun")
            end,
            desc = { description = "Open rofi", group = "Awesome: Launcher" },
        },

        -- Tag
        {
            modifiers = { variables.modkey },
            key = "h",
            run = awful.tag.viewprev,
            desc = { description = "Switch to previous tag", group = "Awesome: Tag" },
        },
        {
            modifiers = { variables.modkey },
            key = "l",
            run = awful.tag.viewnext,
            desc = { description = "Switch to next tag", group = "Awesome: Tag" },
        },
        {
            modifiers = { variables.modkey },
            key = "Escape",
            run = awful.tag.history.restore,
            desc = {
                description = "Switch to latest tag in history",
                group = "Awesome: Tag",
            },
        },

        -- Focus
        {
            modifiers = { variables.modkey },
            key = "j",
            run = function()
                awful.client.focus.byidx(1)
            end,
            desc = {
                description = "Focus next window client by index",
                group = "Awesome: Client",
            },
        },
        {
            modifiers = { variables.modkey },
            key = "k",
            run = function()
                awful.client.focus.byidx(-1)
            end,
            desc = {
                description = "Focus previous window client by index",
                group = "Awesome: Client",
            },
        },
        {
            modifiers = { variables.modkey },
            key = "Tab",
            run = function()
                awful.client.focus.history.previous()
                if client.focus then
                    client.focus:raise()
                end
            end,
            desc = {
                description = "Focus latest client in history",
                group = "Awesome: Client",
            },
        },
        {
            modifiers = { variables.modkey, "Control" },
            key = "j",
            run = function()
                awful.screen.focus_relative(1)
            end,
            desc = { description = "Focus next screen", group = "Awesome: Screen" },
        },
        {
            modifiers = { variables.modkey, "Control" },
            key = "k",
            run = function()
                awful.screen.focus_relative(-1)
            end,
            desc = { description = "Focus previous screen", group = "Awesome: Screen" },
        },

        -- Layout
        {
            modifiers = { variables.modkey, "Shift" },
            key = "j",
            run = function()
                awful.client.swap.byidx(1)
            end,
            desc = {
                description = "Swap with next client by index",
                group = "Awesome: Client",
            },
        },
        {
            modifiers = { variables.modkey, "Shift" },
            key = "k",
            run = function()
                awful.client.swap.byidx(-1)
            end,
            desc = {
                description = "Swap with previous client by index",
                group = "Awesome: Client",
            },
        },
        {
            modifiers = { variables.modkey },
            key = "u",
            run = awful.client.urgent.jumpto,
            desc = { description = "Jump to urgent client", group = "Awesome: Client" },
        },
        {
            modifiers = { variables.modkey },
            key = "Right",
            run = function()
                awful.tag.incmwfact(0.05)
            end,
            desc = {
                description = "Increase master width factor",
                group = "Awesome: Layout",
            },
        },
        {
            modifiers = { variables.modkey },
            key = "Left",
            run = function()
                awful.tag.incmwfact(-0.05)
            end,
            desc = {
                description = "Decrease master width factor",
                group = "Awesome: Layout",
            },
        },
        {
            modifiers = { variables.modkey },
            key = "space",
            run = function()
                awful.layout.inc(1)
            end,
            desc = { description = "Select next layout", group = "Awesome: Layout" },
        },
        {
            modifiers = { variables.modkey, "Shift" },
            key = "space",
            run = function()
                awful.layout.inc(-1)
            end,
            desc = { description = "Select previous layout", group = "Awesome: Layout" },
        },
    },
    client = {
        {
            modifiers = { variables.modkey },
            key = "f",
            run = function(c)
                c.fullscreen = not c.fullscreen
                c:raise()
            end,
            desc = { description = "Toggle fullscreen", group = "Awesome: Client" },
        },
        {
            modifiers = { variables.modkey, "Shift" },
            key = "c",
            run = function(c)
                c:kill()
            end,
            desc = { description = "Close client", group = "Awesome: Client" },
        },
        {
            modifiers = { variables.modkey, "Control" },
            key = "space",
            run = awful.client.floating.toggle,
            desc = { description = "Toggle floating", group = "Awesome: Client" },
        },
        {
            modifiers = { variables.modkey, "Control" },
            key = "Return",
            run = function(c)
                c:swap(awful.client.getmaster())
            end,
            desc = { description = "Swap with master", group = "Awesome: Client" },
        },
        {
            modifiers = { variables.modkey },
            key = "o",
            run = function(c)
                c:move_to_screen()
            end,
            desc = { description = "Move to screen", group = "Awesome: Client" },
        },
        {
            modifiers = { variables.modkey },
            key = "t",
            run = function(c)
                c.ontop = not c.ontop
            end,
            desc = { description = "Toggle keep on top", group = "Awesome: Client" },
        },
    },
}

-- {{{
-- Load mouse bindings
local global_mouse = {}
for _, data in ipairs(mouse_binds.global) do
    local button = awful.button(data.modifiers, data.key, data.run)
    table.insert(global_mouse, button)
end
awful.mouse.append_global_mousebindings(global_mouse)

local client_mouse = {}
for _, data in ipairs(mouse_binds.client) do
    local button = awful.button(data.modifiers, data.key, data.run)
    table.insert(client_mouse, button)
end
client.connect_signal("request::default_mousebindings", function()
    awful.mouse.append_client_mousebindings(client_mouse)
end)
-- }}}

-- {{{
-- Load keybindings
local global_keys = {}
for _, data in ipairs(keybinds.global) do
    local button = awful.key(data.modifiers, data.key, data.run, data.desc)
    table.insert(global_keys, button)
end
awful.keyboard.append_global_keybindings(global_keys)

local client_keys = {}
for _, data in ipairs(keybinds.client) do
    local button = awful.key(data.modifiers, data.key, data.run, data.desc)
    table.insert(client_keys, button)
end
client.connect_signal("request::default_keybindings", function()
    awful.keyboard.append_client_keybindings(client_keys)
end)

-- Number row keys
awful.keyboard.append_global_keybindings({
    awful.key({
        modifiers = { variables.modkey },
        keygroup = "numrow",
        description = "View tag",
        group = "Awesome: Tag",
        on_press = function(index)
            local screen = awful.screen.focused()
            local tag = screen.tags[index]
            if tag then
                tag:view_only()
            end
        end,
    }),

    awful.key({
        modifiers = { variables.modkey, "Control" },
        keygroup = "numrow",
        description = "Toggle tag",
        group = "Awesome: Tag",
        on_press = function(index)
            local screen = awful.screen.focused()
            local tag = screen.tags[index]
            if tag then
                awful.tag.viewtoggle(tag)
            end
        end,
    }),

    awful.key({
        modifiers = { variables.modkey, "Shift" },
        keygroup = "numrow",
        description = "Move focused client to tag",
        group = "Awesome: Tag",
        on_press = function(index)
            if client.focus then
                local tag = client.focus.screen.tags[index]
                if tag then
                    client.focus:move_to_tag(tag)
                end
            end
        end,
    }),

    awful.key({
        modifiers = { variables.modkey, "Control", "Shift" },
        keygroup = "numrow",
        description = "Toggle focused client on tag",
        group = "Awesome: Tag",
        on_press = function(index)
            if client.focus then
                local tag = client.focus.screen.tags[index]
                if tag then
                    client.focus:toggle_tag(tag)
                end
            end
        end,
    }),
})
-- }}}
