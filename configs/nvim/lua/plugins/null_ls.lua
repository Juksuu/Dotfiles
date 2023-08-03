local M = {
    "jayp0521/mason-null-ls.nvim",
    dependencies = "jose-elias-alvarez/null-ls.nvim",
    event = "BufReadPost",
}

function M.config()
    local mason_null = require("mason-null-ls")
    mason_null.setup({
        handlers = {},
    })

    local null = require("null-ls")
    null.setup()
end

return M
