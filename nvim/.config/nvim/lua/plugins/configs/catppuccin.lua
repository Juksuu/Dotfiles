return function()
    local colors = require("catppuccin.core.palettes.init").get_palette() -- fetch colors with API

    local catppuccin = require("catppuccin")
    catppuccin.setup({
        transparent_background = true,
        term_colors = true,
        styles = {
            comments = "NONE",
            conditionals = "NONE",
            loops = "NONE",
            functions = "NONE",
            keywords = "NONE",
            strings = "NONE",
            variables = "NONE",
            numbers = "NONE",
            booleans = "NONE",
            properties = "NONE",
            types = "NONE",
            operators = "NONE",
        },
        integrations = {
            treesitter = true,
            native_lsp = {
                enabled = true,
                virtual_text = {
                    errors = "NONE",
                    hints = "NONE",
                    warnings = "NONE",
                    information = "NONE",
                },
            },
            coc_nvim = false,
            lsp_trouble = false,
            cmp = true,
            lsp_saga = false,
            gitgutter = false,
            gitsigns = true,
            telescope = true,
            nvimtree = {
                enabled = false,
                show_root = false,
                transparent_panel = false,
            },
            neotree = {
                enabled = false,
                show_root = false,
                transparent_panel = false,
            },
            which_key = false,
            indent_blankline = {
                enabled = false,
                colored_indent_levels = false,
            },
            dashboard = false,
            neogit = true,
            vim_sneak = false,
            fern = false,
            barbar = false,
            bufferline = false,
            markdown = false,
            lightspeed = false,
            ts_rainbow = false,
            hop = false,
            notify = false,
            telekasten = false,
            symbols_outline = false,
        },
        custom_highlights = {
            TelescopeNormal = { fg = colors.lavender, bg = colors.surface0 },
            TelescopeBorder = { bg = colors.surface1 },

            TelescopeMatching = { fg = colors.red, bg = colors.none },
            TelescopeSelection = { fg = colors.None, bg = colors.base },

            TelescopeResultsTitle = { fg = colors.lavender, bg = colors.surface1 },

            TelescopePromptTitle = { fg = colors.rosewater, bg = colors.surface2 },
            TelescopePromptPrefix = { fg = colors.rosewater, bg = colors.surface2 },
            TelescopePromptNormal = { fg = colors.rosewater, bg = colors.surface2 },
            TelescopePromptBorder = { bg = colors.surface2 },

            TelescopePreviewTitle = { fg = colors.teal, bg = colors.surface1 },
            TelescopePreviewNormal = { bg = colors.surface1 },
            TelescopePreviewBorder = { bg = colors.surface1 },
        },
    })

    vim.cmd([[ colorscheme catppuccin ]])
end
