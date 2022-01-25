return function()
    vim.g.neoformat_try_node_exe = true
    vim.g.neoformat_only_msg_on_error = true
    vim.g.neoformat_enabled_lua = { "stylua" }

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

    local utils = require("juksu.utils")
    utils.create_autocommands({
        format = { { "BufWritePre", "*", "NeoformatRun" } },
    })
end
