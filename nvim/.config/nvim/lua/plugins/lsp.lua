local M = {
    "williamboman/mason-lspconfig.nvim",
    dependencies = {
        "neovim/nvim-lspconfig",
        { "folke/neodev.nvim", config = true },
        { "williamboman/mason.nvim", config = true },
    },
    event = "BufReadPre",
}

function M.config()
    -- disable lsp watcher. Too slow on linux
    local ok, wf = pcall(require, "vim.lsp._watchfiles")
    if ok then
        wf._watchfunc = function()
            return function() end
        end
    end

    -- Disable gutter signs, color linenum instead
    local sign = function(name)
        vim.fn.sign_define(name, { text = "", numhl = name })
    end
    sign("DiagnosticSignWarn")
    sign("DiagnosticSignInfo")
    sign("DiagnosticSignHint")
    sign("DiagnosticSignError")

    local status, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
    local capabilities = {}
    if status then
        capabilities = cmp_nvim_lsp.default_capabilities()
    end

    vim.g.format_on_save = true
    local toggle_formatting = function()
        vim.g.format_on_save = not vim.g.format_on_save
    end

    vim.g.inlay_hints_visible = false
    local toggle_inlay_hints = function(client, bufnr)
        if vim.g.inlay_hints_visible then
            vim.g.inlay_hints_visible = false
            vim.lsp.inlay_hint(bufnr, false)
        else
            if client.server_capabilities.inlayHintProvider then
                vim.g.inlay_hints_visible = true
                vim.lsp.inlay_hint(bufnr, true)
            else
                print("No inlay hints available")
            end
        end
    end

    vim.g.diagnostics_visible = true
    local toggle_diagnostics = function()
        vim.g.diagnostics_visible = not vim.g.diagnostics_visible
        if vim.g.diagnostics_visible then
            vim.diagnostic.enable()
        else
            vim.diagnostic.disable()
        end
    end

    local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
    local custom_attach = function(client, bufnr)
        client.server_capabilities.semanticTokensProvider = false

        local bufopts = { buffer = bufnr }
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
        vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts)
        vim.keymap.set("n", "gr", vim.lsp.buf.references, bufopts)
        vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, bufopts)
        vim.keymap.set("n", "]d", vim.diagnostic.goto_next, bufopts)
        vim.keymap.set("n", "dl", vim.diagnostic.open_float, bufopts)
        vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, bufopts)
        vim.keymap.set("n", "<leader>la", vim.lsp.buf.code_action, bufopts)
        vim.keymap.set(
            { "n", "i" },
            "<c-k>",
            vim.lsp.buf.signature_help,
            bufopts
        )

        vim.keymap.set("n", "<leader>tf", toggle_formatting, bufopts)
        vim.keymap.set("n", "<leader>td", toggle_diagnostics, bufopts)
        vim.keymap.set("n", "<leader>ti", function()
            toggle_inlay_hints(client, bufnr)
        end, bufopts)

        if client.supports_method("textDocument/formatting") then
            vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
            vim.api.nvim_create_autocmd("BufWritePre", {
                group = augroup,
                buffer = bufnr,
                callback = function()
                    if vim.g.format_on_save then
                        vim.lsp.buf.format({
                            bufnr = bufnr,
                            filter = function(server)
                                return server.name ~= "tssserver"
                            end,
                        })
                    end
                end,
            })
        end
    end

    local mason = require("mason-lspconfig")
    mason.setup()

    local nvim_lsp = require("lspconfig")
    local server_config = require("lsp_servers")

    local setup_server = function(server)
        local opts = server_config.server_settings[server] or {}
        opts.capabilities = capabilities
        opts.on_attach = custom_attach

        nvim_lsp[server].setup(opts)
    end

    mason.setup_handlers({ setup_server })

    for _, v in pairs(server_config.manual_servers) do
        setup_server(v)
    end
end

return M
