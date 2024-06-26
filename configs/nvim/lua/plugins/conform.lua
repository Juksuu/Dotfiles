local M = {
    "stevearc/conform.nvim",
    event = "BufReadPost",
    dependencies = {
        { "folke/neoconf.nvim", config = true },
    },
}

function M.config()
    local conform = require("conform")

    local formatters_by_ft = {
        lua = { "stylua" },
        nix = { "nixfmt" },
        ["*"] = { "codespell" },
        ["_"] = { "trim_whitespace" },

        -- Disable formatting on neogitstatus
        NeogitStatus = nil,
        NeogitCommitMessage = nil,
    }

    local neoconf_formatters = require("neoconf").get("formatters")

    if type(neoconf_formatters) == "table" then
        for ft, formatters in pairs(neoconf_formatters) do
            formatters_by_ft[ft] = formatters
        end
    end

    conform.setup({
        formatters_by_ft = formatters_by_ft,
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
