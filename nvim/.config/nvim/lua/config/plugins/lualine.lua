local M = {
    "nvim-lualine/lualine.nvim",
    event = { "VeryLazy", "BufReadPre" },
}

function M.config()
    local winbar = {
        lualine_a = {
            {
                "filename",
                path = 1,
                icon = "",
                padding = { left = 4 },
            },
        },
    }

    local opts = {
        options = {
            icons_enabled = true,
            theme = "nordic",
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
