return function()
    local nvim_lsp = require("lspconfig")

    -- Disable gutter signs, color linenum instead
    vim.fn.sign_define(
        "DiagnosticSignError",
        { text = "", numhl = "DiagnosticSignError" }
    )
    vim.fn.sign_define(
        "DiagnosticSignWarn",
        { text = "", numhl = "DiagnosticSignWarn" }
    )
    vim.fn.sign_define(
        "DiagnosticSignInfo",
        { text = "", numhl = "DiagnosticSignInfo" }
    )
    vim.fn.sign_define(
        "DiagnosticSignHint",
        { text = "", numhl = "DiagnosticSignHint" }
    )

    vim.lsp.handlers["textDocument/hover"] =
        vim.lsp.with(
            vim.lsp.handlers.hover,
            {
                border = "single",
            }
        )

    vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
        vim.lsp.handlers.signatureHelp,
        {
            border = "single",
        }
    )

    local capabilities = require("cmp_nvim_lsp").update_capabilities(
        vim.lsp.protocol.make_client_capabilities()
    )

    local custom_attach = function(client)
        vim.keymap.set("n", "K", vim.lsp.buf.hover)
        vim.keymap.set("n", "gd", vim.lsp.buf.definition)
        vim.keymap.set("n", "gi", vim.lsp.buf.implementation)
        -- vim.keymap.set("n", "sh", vim.lsp.buf.signature_help)

        vim.keymap.set("n", "[d", vim.diagnostic.goto_prev)
        vim.keymap.set("n", "]d", vim.diagnostic.goto_next)
        vim.keymap.set("n", "<leader>lld", vim.diagnostic.open_float)
        vim.keymap.set("n", "<leader>lR", vim.lsp.buf.rename)

        if client.resolved_capabilities.code_lens then
            vim.cmd([[
              augroup lsp_document_codelens
                au! * <buffer>
                autocmd BufEnter ++once <buffer> lua require"vim.lsp.codelens".refresh()
                autocmd BufWritePost,CursorHold <buffer> lua require"vim.lsp.codelens".refresh()
              augroup END
            ]])
        end
    end

    -- Load lua configuration with nlua.
    require("nlua.lsp.nvim").setup(nvim_lsp, {
        capabilities = capabilities,
        on_attach = custom_attach,
        flags = {
            allow_incremental_sync = true,
        },
    })

    -- Load rust configuration with rust-tools
    require("rust-tools").setup({
        server = {
            capabilities = capabilities,
            on_attach = custom_attach,
            flags = {
                allow_incremental_sync = true,
            },
        },
    })

    local servers = {
        "gopls",
        "tsserver",
        "svelte",
        "yamlls",
        "pylsp",
        "eslint",
    }
    for _, lsp in ipairs(servers) do
        nvim_lsp[lsp].setup({
            capabilities = capabilities,
            on_attach = custom_attach,
            flags = {
                allow_incremental_sync = true,
            },
        })
    end

    -- local eslint = require("lsp.efm.eslint")
    --
    -- local languages = {
    --     typescript = { eslint },
    --     javascript = { eslint },
    --     typescriptreact = { eslint },
    --     ["typescript.tsx"] = { eslint },
    --     javascriptreact = { eslint },
    --     ["javascript.jsx"] = { eslint },
    -- }
    --
    -- -- https://github.com/mattn/efm-langserver
    -- nvim_lsp.efm.setup({
    --     root_dir = function()
    --         return vim.fn.getcwd()
    --     end,
    --     filetypes = vim.tbl_keys(languages),
    --     settings = {
    --         rootMarkers = { "package.json", ".git" },
    --         languages = languages,
    --     },
    --     on_attach = custom_attach,
    --     flags = {
    --         allow_incremental_sync = true,
    --     },
    -- })
end
