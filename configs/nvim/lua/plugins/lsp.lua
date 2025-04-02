local M = {
    "neovim/nvim-lspconfig",
    event = "BufReadPost",
    dependencies = {
        { "folke/neoconf.nvim", config = true },
        { "saghen/blink.cmp" },
    },
}

local custom_attach = function(client, bufnr)
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = bufnr })
    vim.keymap.set(
        "n",
        "<leader>dl",
        vim.diagnostic.open_float,
        { buffer = bufnr }
    )

    vim.keymap.set("n", "K", function()
        vim.lsp.buf.hover({ border = "rounded" })
    end, { buffer = bufnr })

    vim.keymap.set("n", "<C-s>", function()
        vim.lsp.buf.signature_help({ border = "rounded" })
    end, { buffer = bufnr })
end

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

    local nvim_lsp = require("lspconfig")
    local neoconf_lsp_config = require("neoconf").get("lspconfig")
    local blink = require("blink.cmp")

    for server, config in pairs(neoconf_lsp_config) do
        local opts = {
            on_attach = custom_attach,
            capabilities = blink.get_lsp_capabilities(),
        }
        local cmd = config["cmd"]
        if type(cmd) == "table" then
            opts.cmd = cmd
        end

        nvim_lsp[server].setup(opts)
    end
end

return M
