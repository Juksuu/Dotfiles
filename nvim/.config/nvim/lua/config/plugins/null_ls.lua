local M = {
    "jayp0521/mason-null-ls.nvim",
    dependencies = "jose-elias-alvarez/null-ls.nvim",
    event = "BufReadPost",
}

function M.config()
    -- Configure commands for enabling and disabling run on save
    vim.g.format_on_save = true

    vim.api.nvim_create_user_command("FormatOnSaveDisable", function()
        vim.g.format_on_save = false
    end, {})

    vim.api.nvim_create_user_command("FormatOnSaveEnable", function()
        vim.g.format_on_save = true
    end, {})

    local mason_null = require("mason-null-ls")
    mason_null.setup({
        handlers = {},
    })

    local null = require("null-ls")
    null.setup()
end

return M
