return function()
    local nvim_lsp = require("lspconfig")
    local lspconfig_util = require('lspconfig.util')

    vim.lsp.handlers["textDocument/publishDiagnostics"] =
        vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics,
                     {underline = true})

    -- Disable gutter signs, color linenum instead
    vim.fn.sign_define("LspDiagnosticsSignError",
                       {text = "", numhl = "LspDiagnosticsDefaultError"})
    vim.fn.sign_define("LspDiagnosticsSignWarning",
                       {text = "", numhl = "LspDiagnosticsDefaultWarning"})
    vim.fn.sign_define("LspDiagnosticsSignInformation",
                       {text = "", numhl = "LspDiagnosticsDefaultInformation"})
    vim.fn.sign_define("LspDiagnosticsSignHint",
                       {text = "", numhl = "LspDiagnosticsDefaultHint"})

    local custom_init = function(client) end

    local custom_attach = function(client, bufnr) end

    -- Load lua configuration from nlua.
    require('nlua.lsp.nvim').setup(nvim_lsp, {
        on_init = custom_init,
        on_attach = custom_attach
    })

    nvim_lsp.pyls.setup {on_init = custom_init, on_attach = custom_attach}
    nvim_lsp.tsserver.setup {on_init = custom_init, on_attach = custom_attach}
    nvim_lsp.svelte.setup {on_init = custom_init, on_attach = custom_attach}
    nvim_lsp.yamlls.setup {
        on_init = custom_init,
        on_attach = custom_attach
        -- settings = {yaml = {schemas = {kubernetes = "/*"}}}
    }

    local tslint = require('plugin_configs.lsp.efm.tslint')
    local eslint = require('plugin_configs.lsp.efm.eslint')

    local languages = {
        typescript = {tslint, eslint},
        javascript = {tslint, eslint},
        typescriptreact = {tslint, eslint},
        ['typescript.tsx'] = {tslint, eslint},
        javascriptreact = {tslint, eslint},
        ['javascript.jsx'] = {tslint, eslint}
    }

    -- https://github.com/mattn/efm-langserver
    nvim_lsp.efm.setup {
        root_dir = function() return vim.fn.getcwd() end,
        filetypes = vim.tbl_keys(languages),
        settings = {
            rootMarkers = {"package.json", ".git"},
            lintDebounce = 100,
            languages = languages
        }
    }
end
