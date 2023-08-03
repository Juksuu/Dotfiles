local M = {
    "AlexvZyl/nordic.nvim",
    priority = 1000,
}

function M.config()
    local palette = require("nordic.colors")
    require("nordic").setup({
        override = {
            LineNr = { fg = palette.gray5, bg = palette.gray1 },
            SignColumn = { bg = palette.gray1 },
            GitSignsAdd = { bg = palette.gray1 },
            GitSignsDelete = { bg = palette.gray1 },
            GitSignsChange = { bg = palette.gray1 },
            DiagnosticOk = { bg = palette.gray1 },
            DiagnosticInfo = { bg = palette.gray1 },
            DiagnosticHint = { bg = palette.gray1 },
            DiagnosticWarn = { bg = palette.gray1 },
            DiagnosticError = { bg = palette.gray1 },
            NeogitNotificationInfo = { fg = palette.blue2, bg = palette.gray0 },
            NeogitNotificationError = { bg = palette.red.bright },
            NeogitNotificationWarning = { bg = palette.yellow.base },
        },
    })
    require("nordic").load()
end

return M
