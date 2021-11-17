return function()
    require("lualine").setup({
        options = {
            theme = "enfocado",
            component_separators = "",
            section_separators = "",
        },
        sections = {
            lualine_a = { "mode" },
            lualine_b = {
                "branch",
                { "diagnostics", sources = { "nvim_lsp" } },
            },
            lualine_c = {
                function()
                    return "%="
                end,
                "filename",
            },
            lualine_x = { "encoding", "fileformat", "filetype" },
            lualine_z = { "location" },
        },
        inactive_sections = {
            lualine_a = {},
            lualine_b = {},
            lualine_c = { "filename" },
            lualine_x = { "location" },
            lualine_y = {},
            lualine_z = {},
        },
    })
end
