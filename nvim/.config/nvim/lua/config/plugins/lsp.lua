local M = {
    "williamboman/mason-lspconfig.nvim",
    dependencies = {
        "neovim/nvim-lspconfig",
        { "williamboman/mason.nvim", config = true },
    },
    event = "BufReadPre",
}

function M.config()
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

    local custom_attach = function(client, bufnr)
        local bufopts = { noremap = true, silent = true, buffer = bufnr }
        vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
        vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, bufopts)
        vim.keymap.set("n", "]d", vim.diagnostic.goto_next, bufopts)
        vim.keymap.set("n", "dl", vim.diagnostic.open_float, bufopts)
        vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, bufopts)
        vim.keymap.set("n", "<leader>la", "<cmd>CodeActionMenu<CR>", bufopts)
        vim.keymap.set({ "n", "v" }, "<leader>lf", vim.lsp.buf.format, bufopts)
        vim.keymap.set(
            { "n", "i" },
            "<c-k>",
            vim.lsp.buf.signature_help,
            bufopts
        )

        client.server_capabilities.semanticTokensProvider = nil

        if client.server_capabilities.code_lens then
            vim.cmd([[
              augroup lsp_document_codelens
                au! * <buffer>
                autocmd BufEnter ++once <buffer> lua require("vim.lsp.codelens").refresh()
                autocmd BufWritePost,CursorHold <buffer> lua require("vim.lsp.codelens").refresh()
              augroup END
            ]])
        end
    end

    local mason = require("mason-lspconfig")
    mason.setup()

    local nvim_lsp = require("lspconfig")
    local server_config = require("config.lsp_servers")

    local setup_server = function(server, opts)
        opts.capabilities = capabilities
        opts.on_attach = custom_attach

        nvim_lsp[server].setup(opts)
    end

    mason.setup_handlers({
        function(server)
            local server_opts = server_config.server_settings[server] or {}
            setup_server(server, server_opts)
        end,
    })
end

return M
