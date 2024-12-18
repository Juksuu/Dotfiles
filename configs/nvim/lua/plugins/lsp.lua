local M = {
    "neovim/nvim-lspconfig",
    event = "BufReadPost",
    dependencies = {
        { "folke/neoconf.nvim", config = true },
        { "saghen/blink.cmp" },
    },
}

local custom_attach = function(client, bufnr)
    ---Utility for keymap creation.
    ---@param lhs string
    ---@param rhs string|function
    ---@param opts string|table
    ---@param mode? string|string[]
    local function keymap(lhs, rhs, opts, mode)
        opts = type(opts) == "string" and { desc = opts }
            or vim.tbl_extend("error", opts --[[@as table]], { buffer = bufnr })
        mode = mode or "n"
        vim.keymap.set(mode, lhs, rhs, opts)
    end

    client.server_capabilities.semanticTokensProvider = false

    local toggle_inlay_hints = function()
        if client.supports_method("textDocument/inlayHint") then
            local ih = vim.lsp.buf.inlay_hint or vim.lsp.inlay_hint
            local value = not ih.is_enabled({ bufnr })
            ih.enable(value, { bufnr })
        end
    end

    local toggle_diagnostics = function()
        if vim.diagnostic.is_enabled({ bufnr }) then
            vim.diagnostic.enable(false, { bufnr })
        else
            vim.diagnostic.enable(true, { bufnr })
        end
    end

    keymap("gd", vim.lsp.buf.definition, {})
    keymap("<leader>dl", vim.diagnostic.open_float, {})

    keymap("<leader>td", toggle_diagnostics, {})
    keymap("<leader>ti", toggle_inlay_hints, {})

    keymap("K", function()
        vim.lsp.buf.hover({ border = "rounded" })
    end, {})

    keymap("<C-s>", function()
        vim.lsp.buf.signature_help({ border = "rounded" })
    end, {})
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
