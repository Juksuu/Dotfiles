local M = {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = false,
}

function M.config()
    local catppuccin = require("catppuccin")
    catppuccin.setup({
        styles = {
            comments = { "italic" },
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
            dap = {
                enabled = false,
                enable_ui = false, -- enable nvim-dap-ui
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
            notify = true,
            semantic_tokens = false,
            nvimtree = false,
            treesitter_context = true,
            treesitter = true,
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
    })

    vim.cmd([[ colorscheme catppuccin ]])
end

return M
