local M = {
    "jayp0521/mason-null-ls.nvim",
    dependencies = {
        "jose-elias-alvarez/null-ls.nvim",
        { "williamboman/mason.nvim", config = true },
    },
    event = "BufReadPre",
}

function M.config()
    local mason_null = require("mason-null-ls")
    mason_null.setup()

    mason_null.setup_handlers({
        function(source_name, methods)
            require("mason-null-ls.automatic_setup")(source_name, methods)
        end,
    })

    local null = require("null-ls")
    null.setup()

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

return M
