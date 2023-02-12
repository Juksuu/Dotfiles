local wezterm = require("wezterm")

return {
    -- General
    max_fps = 240,
    enable_tab_bar = false,

    -- Font
    font = wezterm.font("Liga SFMono Nerd Font"),
    freetype_load_target = "HorizontalLcd",
    font_size = 11.3,
    line_height = 1.30,

    -- Window
    window_padding = {
        left = 0,
        right = 0,
        top = 0,
        bottom = 0,
    },

    color_scheme = "Catppuccin Mocha",
}
