local noice_conf = function()
    require("noice").setup({
        presets = {
            lsp_doc_border = true,
        },
    })
end

local lualine_conf = function()
    require("lualine").setup({
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
                    symbols = { added = "  ", modified = "  ", removed = "  " },
                },
                "diagnostics",
            },
            lualine_c = {
                {
                    require("noice").api.status.mode.get,
                    cond = require("noice").api.status.mode.has,
                    color = { fg = "#ff9e64" },
                },
            },
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
    })
end

return {
    {
        "catppuccin/nvim",
        as = "catppuccin",
        config = require("packages.theme.catppuccin"),
    },
    {
        "folke/noice.nvim",
        requires = {
            "MunifTanjim/nui.nvim",
            "rcarriga/nvim-notify",
        },
        config = noice_conf,
    },
    {
        "nvim-lualine/lualine.nvim",
        after = "noice.nvim",
        config = lualine_conf,
    },
}
