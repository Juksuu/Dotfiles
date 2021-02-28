local nvim_lsp = require "lspconfig"

local saga = require "lspsaga"
saga.init_lsp_saga()

local lsp_status = require('lsp-status')
lsp_status.register_progress()

local on_attach = function(client, bufnr)
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

nvim_lsp.pyls.setup {
    on_attach = on_attach,
    capabilities = lsp_status.capabilities
}

nvim_lsp.tsserver.setup {
    on_attach = on_attach,
    capabilities = lsp_status.capabilities
}

nvim_lsp.svelte.setup {
    on_attach = on_attach,
    capabilities = lsp_status.capabilities
}

local tslint = require "juksu.efm.linters.tslint"
local eslint = require "juksu.efm.linters.eslint"

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
