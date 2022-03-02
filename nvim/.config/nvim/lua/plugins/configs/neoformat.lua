return function()
    vim.g.neoformat_try_node_exe = true
    vim.g.neoformat_only_msg_on_error = true

    -- Language stuff
    vim.g.neoformat_enabled_lua = { "stylua" }
    vim.g.neoformat_rust_rustfmt2021 = {
        exe = "rustfmt",
        args = { "--edition 2021" },
        stdin = 1,
    }
    vim.g.neoformat_enabled_rust = { "rustfmt2021" }

    -- Configure commands for enabling and disabling run on save
    vim.g.neoformat_run_on_save = true

    vim.api.nvim_add_user_command("NeoformatDisableOnSave", function()
        vim.g.neoformat_run_on_save = false
    end, {})

    vim.api.nvim_add_user_command("NeoformatEnableOnSave", function()
        vim.g.neoformat_run_on_save = true
    end, {})

    vim.api.nvim_add_user_command("NeoformatRun", function()
        if vim.g.neoformat_run_on_save then
            vim.api.nvim_command("Neoformat")
        end
    end, {})

    vim.api.nvim_create_autocmd("BufWritePre", { command = "NeoformatRun" })
end
