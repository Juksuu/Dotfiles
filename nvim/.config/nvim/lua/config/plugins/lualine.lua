local M = {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
}

function M.config()
    local opts = {
        options = {
            icons_enabled = true,
            theme = "catppuccin",
            component_separators = { left = "", right = "" },
            section_separators = { left = "", right = "" },
        },
        sections = {
            lualine_a = {
                { "mode", icon = "" },
                { "branch", icon = "" },
            },
            lualine_b = {
                {
                    "diff",
                    symbols = {
                        added = "  ",
                        modified = "  ",
                        removed = "  ",
                    },
                },
                "diagnostics",
            },
            lualine_c = {},
            lualine_x = { "location", "fileformat" },
            lualine_y = {},
            lualine_z = { "filename" },
        },
        winbar = {
            lualine_c = { "filename" },
        },
        inactive_winbar = {
            lualine_c = { "filename" },
        },
    }

    local has_noice, _ = pcall(require, "noice")
    if has_noice then
        opts.lualine_c = {
            {
                require("noice").api.status.mode.get,
                cond = require("noice").api.status.mode.has,
                color = { fg = "#ff9e64" },
            },
        }
    end
    require("lualine").setup(opts)
end

return M