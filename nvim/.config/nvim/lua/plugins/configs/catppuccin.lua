return function()
    local catppuccin = require("catppuccin")
    catppuccin.setup({
        transparent_background = true,
        term_colors = true,
        styles = {
            comments = "None",
            functions = "None",
            keywords = "None",
            strings = "None",
            variables = "None",
        },
        integrations = {
            treesitter = true,
            native_lsp = {
                enabled = true,
                virtual_text = {
                    errors = "None",
                    hints = "None",
                    warnings = "None",
                    information = "None",
                },
            },
            cmp = true,
            gitsigns = true,
            telescope = true,
            nvimtree = {
                enabled = false,
                show_root = false,
            },
            indent_blankline = {
                enabled = false,
                colored_indent_levels = false,
            },
            dashboard = false,
            neogit = true,
            bufferline = false,
            notify = true,
            telekasten = false,
        },
    })

    local colors = require("catppuccin.api.colors").get_colors() -- fetch colors with API
    catppuccin.remap({
        TelescopeNormal = { fg = colors.lavender, bg = colors.black1 },
        TelescopeBorder = { bg = colors.black1 },

        TelescopeMatching = { fg = colors.red, bg = colors.None },
        TelescopeSelection = { fg = colors.None, bg = colors.black2 },

        TelescopeResultsTitle = { fg = colors.lavender, bg = colors.black1 },

        TelescopePromptTitle = { fg = colors.rosewater, bg = colors.black3 },
        TelescopePromptPrefix = { fg = colors.rosewater, bg = colors.black3 },
        TelescopePromptNormal = { fg = colors.rosewater, bg = colors.black3 },
        TelescopePromptBorder = { bg = colors.black3 },

        TelescopePreviewTitle = { fg = colors.teal, bg = colors.black2 },
        TelescopePreviewNormal = { bg = colors.black2 },
        TelescopePreviewBorder = { bg = colors.black2 },
    })

    vim.cmd([[ colorscheme catppuccin ]])
end
