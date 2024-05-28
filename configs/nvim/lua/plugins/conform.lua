local M = {
    "stevearc/conform.nvim",
    event = "BufReadPost",
}

function M.config()
    local conform = require("conform")

    conform.setup({
        formatters_by_ft = {
            lua = { "stylua" },
            nix = { "nixfmt" },
            ["*"] = { "codespell" },
            ["_"] = { "trim_whitespace" },

            -- Disable formatting on neogitstatus
            NeogitStatus = nil,
            NeogitCommitMessage = nil,
        },
        format_on_save = nil,
    })

    vim.api.nvim_create_autocmd("BufWritePre", {
        pattern = "*",
        callback = function(args)
            conform.format({
                lsp_fallback = true,
                bufnr = args.buf,
            })
        end,
    })
end

return M
