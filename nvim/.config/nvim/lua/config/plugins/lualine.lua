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
            },
            lualine_b = {},
            lualine_c = {
                { "branch", icon = "" },
            },

            lualine_x = {
                "diagnostics",
                {
                    "diff",
                    symbols = {
                        added = "  ",
                        modified = "  ",
                        removed = "  ",
                    },
                },
            },
            lualine_y = {},
            lualine_z = { "filename", "fileformat" },
        },
        winbar = winbar,
        inactive_winbar = winbar,
    }

    local has_spotify, spotify = pcall(require, "nvim-spotify")
    if has_spotify then
        local status = spotify.status
        status:start()
        table.insert(opts.sections.lualine_c, {
            status.listen,
        })
    end

    local has_noice, noice = pcall(require, "noice")
    if has_noice then
        table.insert(opts.sections.lualine_c, {
            noice.api.status.mode.get,
            cond = noice.api.status.mode.has,
            color = { fg = "#ff9e64" },
        })
    end
    require("lualine").setup(opts)
end

return M
