return function()
    require("catppuccin").setup({
        transparent_background = true,
        term_colors = false,
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
                enabled = true,
                show_root = false,
            },
            indent_blankline = {
                enabled = false,
                colored_indent_levels = false,
            },
            dashboard = false,
            neogit = false,
            bufferline = false,
            notify = false,
            telekasten = false,
        },
    })

    vim.cmd([[ colorscheme catppuccin ]])
end
