return function()
    require("lualine").setup({
        options = {
            theme = "onedarkpro",
            component_separators = "",
            section_separators = { left = "", right = "" },
        },
        sections = {
            lualine_a = { "mode" },
            lualine_b = {
                "branch",
                "diff",
            },
            lualine_x = { "fileformat" },
            lualine_y = { "filetype" },
            lualine_z = { "location" },
        },
        inactive_sections = {
            lualine_a = { "mode" },
            lualine_b = {
                "branch",
                "diff",
            },
            lualine_x = { "fileformat" },
            lualine_y = { "filetype" },
            lualine_z = { "location" },
        },
    })
end
