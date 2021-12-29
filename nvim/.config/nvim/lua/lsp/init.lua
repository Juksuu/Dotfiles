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
        local utils = require("juksu.utils")

        utils.map("n", "K", "<cmd> lua vim.lsp.buf.hover() <CR>")
        utils.map(
            "n",
            "<leader>lld",
            "<cmd> lua vim.diagnostic.open_float({ border = 'single' }) <CR>"
        )
        utils.map("n", "<leader>lR", "<cmd> lua vim.lsp.buf.rename() <CR>")

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

    -- Load lua configuration from nlua.
    require("nlua.lsp.nvim").setup(nvim_lsp, {
        capabilities = capabilities,
        on_attach = custom_attach,
        flags = {
            allow_incremental_sync = true,
        },
    })

    local servers = { "gopls", "tsserver", "svelte", "yamlls", "gdscript" }
    for _, lsp in ipairs(servers) do
        nvim_lsp[lsp].setup({
            capabilities = capabilities,
            on_attach = custom_attach,
            flags = {
                allow_incremental_sync = true,
            },
        })
    end

    local tslint = require("lsp.efm.tslint")
    local eslint = require("lsp.efm.eslint")

    local languages = {
        typescript = { tslint, eslint },
        javascript = { tslint, eslint },
        typescriptreact = { tslint, eslint },
        ["typescript.tsx"] = { tslint, eslint },
        javascriptreact = { tslint, eslint },
        ["javascript.jsx"] = { tslint, eslint },
    }

    -- https://github.com/mattn/efm-langserver
    nvim_lsp.efm.setup({
        root_dir = function()
            return vim.fn.getcwd()
        end,
        filetypes = vim.tbl_keys(languages),
        settings = {
            rootMarkers = { "package.json", ".git" },
            lintDebounce = 100,
            languages = languages,
        },
        on_attach = custom_attach,
        flags = {
            allow_incremental_sync = true,
        },
    })
end
