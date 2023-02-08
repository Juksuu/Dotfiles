local M = {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = false,
}

function M.config()
    local catppuccin = require("catppuccin")
    catppuccin.setup({
        flavour = "mocha",
        background = { light = "latte", dark = "mocha" },
        dim_inactive = {
            enabled = false,
        },
        transparent_background = false,
        show_end_of_buffer = false, -- show the '~' characters after the end of buffers
        term_colors = true,
        compile_path = vim.fn.stdpath("cache") .. "/catppuccin",
        no_italic = true,
        no_bold = true,
        integrations = {
            dap = {
                enabled = false,
                enable_ui = false,
            },
            native_lsp = {
                enabled = true,
                virtual_text = {
                    errors = { "italic" },
                    hints = { "italic" },
                    warnings = { "italic" },
                    information = { "italic" },
                },
                underlines = {
                    errors = { "underline" },
                    hints = { "underline" },
                    warnings = { "underline" },
                    information = { "underline" },
                },
            },
            navic = {
                enabled = false,
                custom_bg = "NONE",
            },
            indent_blankline = {
                enabled = false,
                colored_indent_levels = false,
            },
            aerial = false,
            barbar = false,
            beacon = false,
            dashboard = false,
            fern = false,
            fidget = false,
            gitsigns = true,
            harpoon = false,
            hop = false,
            leap = false,
            lightspeed = false,
            lsp_saga = false,
            markdown = true,
            mason = true,
            mini = false,
            neotree = false,
            neogit = true,
            neotest = false,
            noice = true,
            cmp = true,
            notify = false,
            semantic_tokens = true,
            nvimtree = false,
            treesitter = true,
            treesitter_context = true,
            ts_rainbow = false,
            overseer = false,
            pounce = false,
            symbols_outline = false,
            telekasten = false,
            telescope = true,
            lsp_trouble = false,
            gitgutter = false,
            illuminate = false,
            vim_sneak = false,
            vimwiki = false,
            which_key = false,
        },
        custom_highlights = function(color)
            return {
                CmpItemKindSnippet = { fg = color.base, bg = color.mauve },
                CmpItemKindKeyword = { fg = color.base, bg = color.red },
                CmpItemKindText = { fg = color.base, bg = color.teal },
                CmpItemKindMethod = { fg = color.base, bg = color.blue },
                CmpItemKindConstructor = { fg = color.base, bg = color.blue },
                CmpItemKindFunction = { fg = color.base, bg = color.blue },
                CmpItemKindFolder = { fg = color.base, bg = color.blue },
                CmpItemKindModule = { fg = color.base, bg = color.blue },
                CmpItemKindConstant = { fg = color.base, bg = color.peach },
                CmpItemKindField = { fg = color.base, bg = color.green },
                CmpItemKindProperty = { fg = color.base, bg = color.green },
                CmpItemKindEnum = { fg = color.base, bg = color.green },
                CmpItemKindUnit = { fg = color.base, bg = color.green },
                CmpItemKindClass = { fg = color.base, bg = color.yellow },
                CmpItemKindVariable = { fg = color.base, bg = color.flamingo },
                CmpItemKindFile = { fg = color.base, bg = color.blue },
                CmpItemKindInterface = { fg = color.base, bg = color.yellow },
                CmpItemKindColor = { fg = color.base, bg = color.red },
                CmpItemKindReference = { fg = color.base, bg = color.red },
                CmpItemKindEnumMember = { fg = color.base, bg = color.red },
                CmpItemKindStruct = { fg = color.base, bg = color.blue },
                CmpItemKindValue = { fg = color.base, bg = color.peach },
                CmpItemKindEvent = { fg = color.base, bg = color.blue },
                CmpItemKindOperator = { fg = color.base, bg = color.blue },
                CmpItemKindTypeParameter = { fg = color.base, bg = color.blue },
                CmpItemKindCopilot = { fg = color.base, bg = color.teal },
            }
        end,
    })

    vim.cmd([[ colorscheme catppuccin ]])
end

return M
