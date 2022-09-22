return function()
    require("null-ls").setup({
        sources = {
            require("null-ls").builtins.formatting.stylua,
            require("null-ls").builtins.formatting.prettierd,

            require("null-ls").builtins.code_actions.eslint_d,

            require("null-ls").builtins.diagnostics.eslint_d,
        },
    })

    require("mason-null-ls").setup({
        automatic_installation = true,
    })
end
