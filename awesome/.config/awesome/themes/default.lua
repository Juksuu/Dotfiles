---------------------------
-- Default awesome theme --
---------------------------

local theme_assets = require("beautiful.theme_assets")
local xresources = require("beautiful.xresources")
local rnotification = require("ruled.notification")
local dpi = xresources.apply_dpi

local gfs = require("gears.filesystem")
local themes_path = gfs.get_themes_dir()

local theme = {}

theme.font = "sans 10"

theme.palette_c1 = "#d17bed"
theme.palette_c2 = "#96eef2"
theme.palette_c3 = "#2f2b3a"
theme.palette_c4 = "#CCB8F0"
theme.palette_c5 = "#333170"
theme.palette_c6 = "#4b455c"
theme.palette_c7 = "#564d70"
theme.col_transparent = "#00000000"

theme.bg_normal = theme.palette_c3
theme.bg_focus = theme.palette_c3
theme.bg_urgent = theme.palette_c1
theme.bg_minimize = "#444444"
theme.bg_systray = theme.bg_normal

theme.fg_normal = theme.palette_c2
theme.fg_focus = theme.palette_c4
theme.fg_urgent = "#d61ff0"
theme.fg_minimize = "#ffffff"

theme.useless_gap = dpi(8)
theme.border_width = dpi(2)
theme.border_color_normal = theme.palette_c2
theme.border_color_active = theme.palette_c1
theme.border_color_marked = "#91231c"

theme.menu_submenu_icon = themes_path .. "default/submenu.png"
theme.menu_height = dpi(15)
theme.menu_width = dpi(100)

-- Generate Awesome icon:
theme.awesome_icon =
    theme_assets.awesome_icon(theme.menu_height, theme.bg_focus, theme.fg_focus)

-- Define the icon theme for application icons. If not set then the icons
-- from /usr/share/icons and /usr/share/icons/hicolor will be used.
theme.icon_theme = nil

-- Set different colors for urgent notifications.
rnotification.connect_signal("request::rules", function()
    rnotification.append_rule({
        rule = { urgency = "critical" },
        properties = { bg = "#ff0000", fg = "#ffffff" },
    })
end)

return theme

-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:textwidth=80
