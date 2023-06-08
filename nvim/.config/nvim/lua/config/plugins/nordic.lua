local M = {
    "AlexvZyl/nordic.nvim",
    priority = 1000,
}

function M.config()
    local palette = require("nordic.colors")
    require("nordic").setup({
        override = {
            LazyNormal = {
                fg = palette.fg,
                bg = palette.bg_dark,
            },
        },
    })
    require("nordic").load()
end

return M
