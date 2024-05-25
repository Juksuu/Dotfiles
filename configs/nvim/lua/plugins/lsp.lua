local M = {
    "neovim/nvim-lspconfig",
    dependencies = {
        { "folke/neodev.nvim", config = true },
    },
    event = "BufReadPre",
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

    vim.lsp.handlers["textDocument/hover"] =
        vim.lsp.with(vim.lsp.handlers.hover, {
            border = "rounded",
        })

    vim.lsp.handlers["textDocument/signatureHelp"] =
        vim.lsp.with(vim.lsp.handlers.signature_help, {
            border = "rounded",
        })

    local status, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
    local capabilities = {}
    if status then
        capabilities = cmp_nvim_lsp.default_capabilities()
    end

    local toggle_inlay_hints = function(client, bufnr)
        if client.supports_method("textDocument/inlayHint") then
            local ih = vim.lsp.buf.inlay_hint or vim.lsp.inlay_hint
            local value = not ih.is_enabled({ bufnr })
            ih.enable(value, { bufnr })
        end
    end

    local toggle_diagnostics = function(_, bufnr)
        if vim.diagnostic.is_enabled(bufnr) then
            vim.diagnostic.enable(false, { bufnr })
        else
            vim.diagnostic.enable(true, { bufnr })
        end
    end

    local custom_attach = function(client, bufnr)
        client.server_capabilities.semanticTokensProvider = false

        local bufopts = { buffer = bufnr }
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
        vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts)
        vim.keymap.set("n", "gr", vim.lsp.buf.references, bufopts)
        vim.keymap.set("n", "dl", vim.diagnostic.open_float, bufopts)
        vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, bufopts)
        vim.keymap.set("n", "<leader>la", vim.lsp.buf.code_action, bufopts)
        vim.keymap.set(
            { "n", "i" },
            "<c-s>",
            vim.lsp.buf.signature_help,
            bufopts
        )

        vim.keymap.set("n", "<leader>td", function()
            toggle_diagnostics(client, bufnr)
        end, bufopts)

        vim.keymap.set("n", "<leader>ti", function()
            toggle_inlay_hints(client, bufnr)
        end, bufopts)

        -- toggle_inlay_hints(client, bufnr)
    end

    local nvim_lsp = require("lspconfig")
    local server_config = require("lsp_servers")

    local setup_server = function(server)
        local opts = server_config.settings[server] or {}
        opts.capabilities = capabilities
        opts.on_attach = custom_attach

        nvim_lsp[server].setup(opts)
    end

    for _, v in pairs(server_config.servers) do
        setup_server(v)
    end
end

return M
