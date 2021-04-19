local nvim_lsp = require("lspconfig")
local lspconfig_util = require('lspconfig.util')

local lsp_status = require('lsp-status')

local custom_init = function(client)
    client.config.flags = client.config.flags or {}
    client.config.flags.allow_incremental_sync = true
end

local custom_attach = function(client, bufnr)
    local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
    local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

    buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- Lsp status
    lsp_status.on_attach(client)

    -- Mappings.
    local opts = { noremap=true, silent=true }

    -- Set some keybinds conditional on server capabilities
    if client.resolved_capabilities.document_formatting then
        buf_set_keymap("n", "<space>cF", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
    elseif client.resolved_capabilities.document_range_formatting then
        buf_set_keymap("n", "<space>cF", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
    end

end

-- Load lua configuration from nlua.
require('nlua.lsp.nvim').setup(nvim_lsp, {
    on_init = custom_init,
    on_attach = custom_attach,

    root_dir = function(fname)
        if string.find(vim.fn.fnamemodify(fname, ":p"), ".config/nvim/") then
            return vim.fn.expand("~/.config/nvim/")
        end

        return lspconfig_util.find_git_ancestor(fname)
            or lspconfig_util.path.dirname(fname)
    end,

    globals = {
        -- Colorbuddy
        "Color", "c", "Group", "g", "s",

        -- Custom
        "RELOAD",
    }
})

nvim_lsp.pyls.setup {
    on_init = custom_init,
    on_attach = custom_attach,
    capabilities = lsp_status.capabilities
}

nvim_lsp.tsserver.setup {
    on_init = custom_init,
    on_attach = custom_attach,
    capabilities = lsp_status.capabilities
}

nvim_lsp.svelte.setup {
    on_init = custom_init,
    on_attach = custom_attach,
    capabilities = lsp_status.capabilities
}

local tslint = require('modules.lsp.efm.linters.tslint')
local eslint = require('modules.lsp.efm.linters.eslint')

local languages = {
    --lua = {luafmt},
    typescript = {tslint, eslint},
    javascript = {tslint, eslint},
    typescriptreact = {tslint, eslint},
    ['typescript.tsx'] = {tslint, eslint},
    javascriptreact = {tslint, eslint},
    ['javascript.jsx'] = {tslint, eslint},
}

-- https://github.com/mattn/efm-langserver
nvim_lsp.efm.setup {
    root_dir = function()
        return vim.fn.getcwd()
    end,
    filetypes = vim.tbl_keys(languages),
    settings = {
        rootMarkers = { "package.json", ".git" },
        lintDebounce = 100,
        languages = languages
    },
}
