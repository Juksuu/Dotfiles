return function()
    local colors = require("catppuccin.palettes").get_palette() -- fetch colors with API

    local catppuccin = require("catppuccin")
    catppuccin.setup({
        dim_inactive = {
            enabled = false,
            shade = "dark",
            percentage = 0.15,
        },
        transparent_background = true,
        term_colors = true,
        compile = {
            enabled = true,
            path = vim.fn.stdpath("cache") .. "/catppuccin",
        },
        styles = {
            comments = {},
            conditionals = {},
            loops = {},
            functions = {},
            keywords = {},
            strings = {},
            variables = {},
            numbers = {},
            booleans = {},
            properties = {},
            types = {},
            operators = {},
        },
        integrations = {
            treesitter = true,
            native_lsp = {
                enabled = true,
                virtual_text = {
                    errors = {},
                    hints = {},
                    warnings = {},
                    information = {},
                },
                underlines = {
                    errors = { "underline" },
                    hints = { "underline" },
                    warnings = { "underline" },
                    information = { "underline" },
                },
            },
            coc_nvim = false,
            lsp_trouble = false,
            cmp = true,
            lsp_saga = false,
            gitgutter = false,
            gitsigns = true,
            leap = false,
            telescope = true,
            nvimtree = {
                enabled = false,
                show_root = true,
                transparent_panel = false,
            },
            neotree = {
                enabled = false,
                show_root = true,
                transparent_panel = false,
            },
            dap = {
                enabled = false,
                enable_ui = false,
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
            mini = false,
            aerial = false,
            vimwiki = false,
            beacon = false,
        },
        color_overrides = {},
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
