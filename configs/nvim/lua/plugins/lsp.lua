local M = {
    "neovim/nvim-lspconfig",
    lazy = false,
}

function M.config()
    vim.diagnostic.config({
        underline = true,
        update_in_insert = false,
        severity_sort = true,
        signs = {
            text = {
                [vim.diagnostic.severity.HINT] = "",
                [vim.diagnostic.severity.INFO] = "",
                [vim.diagnostic.severity.WARN] = "",
                [vim.diagnostic.severity.ERROR] = "",
            },
            numhl = {
                [vim.diagnostic.severity.HINT] = "DiagnosticSignHint",
                [vim.diagnostic.severity.INFO] = "DiagnosticSignInfo",
                [vim.diagnostic.severity.WARN] = "DiagnosticSignWarn",
                [vim.diagnostic.severity.ERROR] = "DiagnosticSignError",
            },
        },
    })

    vim.lsp.on_type_formatting.enable()

    vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
            vim.keymap.set(
                "n",
                "gd",
                vim.lsp.buf.definition,
                { buffer = args.buf }
            )
            vim.keymap.set(
                "n",
                "<leader>dl",
                vim.diagnostic.open_float,
                { buffer = args.buf }
            )

            vim.keymap.set("n", "K", function()
                vim.lsp.buf.hover({ border = "rounded" })
            end, { buffer = args.buf })

            vim.keymap.set("n", "<C-s>", function()
                vim.lsp.buf.signature_help({ border = "rounded" })
            end, { buffer = args.buf })
        end,
    })

    vim.lsp.enable({ "lua_ls", "jsonls", "html" })
end

return M
