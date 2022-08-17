local awful = require("awful")
local wibox = require("wibox")
local gears = require("gears")
local beautiful = require("beautiful")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi

-- {{{
-- Wallpaper
screen.connect_signal("request::wallpaper", function(s)
    awful.wallpaper({
        screen = s,
        widget = {
            vertical_fit_policy = "fit",
            horizontal_fit_policy = "fit",
            image = os.getenv("HOME") .. "/Wallpapers/Clearday.png",
            widget = wibox.widget.imagebox,
        },
    })
end)

-- }}}

-- {{{
-- Wibar

local layout_buttons = {
    awful.button({}, 1, function()
        awful.layout.inc(1)
    end),
    awful.button({}, 3, function()
        awful.layout.inc(-1)
    end),
    awful.button({}, 4, function()
        awful.layout.inc(-1)
    end),
    awful.button({}, 5, function()
        awful.layout.inc(1)
    end),
}

local tasklist_buttons = {
    awful.button({}, 1, function(c)
        c:activate({ context = "tasklist", action = "toggle_minimization" })
    end),
    awful.button({}, 3, function()
        awful.menu.client_list({ theme = { width = 250 } })
    end),
    awful.button({}, 4, function()
        awful.client.focus.byidx(-1)
    end),
    awful.button({}, 5, function()
        awful.client.focus.byidx(1)
    end),
}

local shapes = {}
shapes.partially_rounded_rect = function(radius, tl, tr, br, bl)
    return function(cr, width, height)
        gears.shape.partially_rounded_rect(cr, width, height, tl, tr, br, bl, radius)
    end
end

-- Keyboard map indicator and switcher
local mykeyboardlayout = awful.widget.keyboardlayout()

-- Create a textclock widget
local mytextclock = wibox.widget.textclock()

screen.connect_signal("request::desktop_decoration", function(s)
    -- Each screen has its own tag table.
    local layout = {
        awful.layout.layouts[1],
        awful.layout.layouts[3],
    }
    awful.tag({ "Web", "Dev", "Misc" }, s, layout[s.index])

    -- Create a promptbox for each screen
    s.mypromptbox = awful.widget.prompt()

    -- Create an imagebox widget which will contain an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    s.mylayoutbox = awful.widget.layoutbox({
        screen = s,
        buttons = layout_buttons,
    })

    -- Create a taglist widget
    s.mytaglist = awful.widget.taglist({
        screen = s,
        filter = awful.widget.taglist.filter.all,
        widget_template = {
            {
                {
                    {
                        {
                            {
                                id = "text_role",
                                widget = wibox.widget.textbox,
                            },
                            layout = wibox.layout.fixed.horizontal,
                        },
                        widget = wibox.container.margin,
                    },
                    widget = wibox.container.background,
                },
                margins = {
                    top = 5,
                    bottom = 5,
                    left = 5,
                    right = 6,
                },
                widget = wibox.container.margin,
            },
            id = "background_role",
            bg = beautiful.palette_c3,
            widget = wibox.container.background,
        },
    })

    -- Create a tasklist widget
    s.focused_task = awful.widget.tasklist({
        screen = s,
        filter = awful.widget.tasklist.filter.focused,
        buttons = tasklist_buttons,
        widget_template = {
            {
                left = 7,
                right = 7,
                widget = wibox.container.margin,
                {
                    layout = wibox.container.scroll.horizontal,
                    max_size = 400,
                    step_function = wibox.container.scroll.step_functions.waiting_nonlinear_back_and_forth,
                    speed = 300,
                    {
                        id = "text_role",
                        widget = wibox.widget.textbox,
                        align = "center",
                        valign = "center",
                    },
                },
            },
            widget = wibox.container.background,
        },
    })

    -- Create the wibox
    s.mywibox = awful.wibar({
        position = "top",
        screen = s,
        bg = beautiful.col_transparent,
        widget = {
            widget = wibox.container.margin,
            top = dpi(4),
            left = dpi(7),
            right = dpi(7),
            {

                layout = wibox.layout.align.horizontal,
                { -- Left widgets
                    layout = wibox.layout.fixed.horizontal,
                    {
                        widget = wibox.container.background,
                        bg = beautiful.palette_c3,
                        shape = shapes.partially_rounded_rect(7, true, true, true, true),
                        {
                            layout = wibox.layout.fixed.horizontal,
                            s.mytaglist,
                        },
                    },
                    {
                        widget = wibox.container.margin,
                        left = dpi(20),
                        {
                            widget = wibox.container.background,
                            bg = beautiful.palette_c3,
                            shape = shapes.partially_rounded_rect(
                                7,
                                true,
                                true,
                                true,
                                true
                            ),
                            {

                                layout = wibox.layout.fixed.horizontal,
                                s.focused_task,
                            },
                        },
                    },
                },
                { -- Middle widgets
                    layout = wibox.layout.fixed.horizontal,
                },
                { -- Right widgets
                    layout = wibox.layout.fixed.horizontal,
                    {
                        widget = wibox.container.margin,
                        right = dpi(10),
                        {
                            widget = wibox.container.background,
                            bg = beautiful.palette_c3,
                            shape = shapes.partially_rounded_rect(
                                7,
                                true,
                                true,
                                true,
                                true
                            ),
                            {
                                widget = wibox.container.margin,
                                left = 8,
                                right = 8,
                                {
                                    layout = wibox.layout.fixed.horizontal,
                                    wibox.widget.systray(),
                                },
                            },
                        },
                    },
                    {
                        widget = wibox.container.margin,
                        right = dpi(10),
                        {
                            widget = wibox.container.background,
                            bg = beautiful.palette_c3,
                            shape = shapes.partially_rounded_rect(
                                7,
                                true,
                                true,
                                true,
                                true
                            ),
                            {
                                widget = wibox.container.margin,
                                left = 5,
                                right = 5,
                                {
                                    layout = wibox.layout.fixed.horizontal,
                                    mykeyboardlayout,
                                },
                            },
                        },
                    },
                    {
                        widget = wibox.container.background,
                        bg = beautiful.palette_c3,
                        shape = shapes.partially_rounded_rect(7, true, true, true, true),
                        {

                            layout = wibox.layout.fixed.horizontal,
                            mytextclock,
                        },
                    },
                },
            },
        },
    })
end)

-- }}}
