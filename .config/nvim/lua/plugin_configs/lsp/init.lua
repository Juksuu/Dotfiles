return function()
    local nvim_lsp = require("lspconfig")
    local coq = require("coq")

    -- Disable gutter signs, color linenum instead
    vim.fn.sign_define(
        "LspDiagnosticsSignError",
        { text = "", numhl = "LspDiagnosticsDefaultError" }
    )
    vim.fn.sign_define(
        "LspDiagnosticsSignWarning",
        { text = "", numhl = "LspDiagnosticsDefaultWarning" }
    )
    vim.fn.sign_define(
        "LspDiagnosticsSignInformation",
        { text = "", numhl = "LspDiagnosticsDefaultInformation" }
    )
    vim.fn.sign_define(
        "LspDiagnosticsSignHint",
        { text = "", numhl = "LspDiagnosticsDefaultHint" }
    )

    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities.textDocument.completion.completionItem.snippetSupport = true
    capabilities.textDocument.completion.completionItem.resolveSupport = {
        properties = { "documentation", "detail", "additionalTextEdits" },
    }

    -- Load lua configuration from nlua.
    require("nlua.lsp.nvim").setup(nvim_lsp, {
        coq.lsp_ensure_capabilities({ capabilities = capabilities }),
    })

    local servers = { "gopls", "tsserver", "svelte", "yamlls", "gdscript" }
    for _, lsp in ipairs(servers) do
        nvim_lsp[lsp].setup({
            coq.lsp_ensure_capabilities({ capabilities = capabilities }),
        })
    end

    local tslint = require("plugin_configs.lsp.efm.tslint")
    local eslint = require("plugin_configs.lsp.efm.eslint")

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
    })
end
