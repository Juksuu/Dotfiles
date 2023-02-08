local M = {
    "nvim-lualine/lualine.nvim",
    dependencies = {
        {
            "SmiteshP/nvim-navic",
            opts = { separator = "  ", highlight = true },
        },
    },
    event = { "VeryLazy", "BufReadPre" },
}

function M.config()
    local winbar = {
        lualine_x = {
            {
                "filename",
                path = 1,
                icon = "",
                padding = { left = 4 },
            },
        },
    }

    local has_navic, navic = pcall(require, "nvim-navic")
    if has_navic then
        winbar.lualine_c = {
            {
                navic.get_location,
                icon = "",
                cond = navic.is_available,
            },
        }
    end
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
            lualine_x = { "location", "fileformat" },
            lualine_z = { "filename" },
        },
        winbar = winbar,
        inactive_winbar = winbar,
    }

    local has_noice, noice = pcall(require, "noice")
    if has_noice then
        opts.sections.lualine_c = {
            {
                noice.api.status.mode.get,
                cond = noice.api.status.mode.has,
                color = { fg = "#ff9e64" },
            },
        }
    end
    require("lualine").setup(opts)
end

return M
