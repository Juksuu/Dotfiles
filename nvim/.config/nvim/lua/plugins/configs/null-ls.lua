return function()
    require("null-ls").setup({
        sources = {
            require("null-ls").builtins.formatting.stylua,
            require("null-ls").builtins.formatting.prettier,
            require("null-ls").builtins.formatting.rustfmt,
            require("null-ls").builtins.formatting.black,

            require("null-ls").builtins.code_actions.eslint_d,

            require("null-ls").builtins.diagnostics.eslint_d,
        },
    })

    require("mason-null-ls").setup({
        automatic_installation = true,
    })

    -- Configure commands for enabling and disabling run on save
    vim.g.format_on_save = true

    vim.api.nvim_create_user_command("FormatOnSaveDisable", function()
        vim.g.format_on_save = false
    end, {})

    vim.api.nvim_create_user_command("FormatOnSaveEnable", function()
        vim.g.format_on_save = true
    end, {})

    local group = vim.api.nvim_create_augroup("AutoFormat", { clear = true })
    vim.api.nvim_create_autocmd("BufWritePre", {
        callback = function()
            if vim.g.format_on_save then
                vim.lsp.buf.format()
            end
        end,
        group = group,
    })
end
