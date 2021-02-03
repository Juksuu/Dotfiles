local nvim_lsp = require "lspconfig"

local saga = require "lspsaga"
saga.init_lsp_saga()

local lsp_status = require('lsp-status')
lsp_status.register_progress()

vim.g.completion_matching_smart_case = 1
vim.g.completion_matching_strategy_list = {"exact", "substring"}

local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Completion
  require'completion'.on_attach(client)

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

local tslint = require "efm/tslint"

-- https://github.com/mattn/efm-langserver
nvim_lsp.efm.setup {
    settings = {
        rootMarkers = { '.git/' },
        languages = {
            typescript = { tslint },
            javascript = { tslint },
            typescriptreact = { tslint },
            javascriptreact = { tslint }
        }
    }
}

local eslint = require('diagnosticls.linters.eslint')
nvim_lsp.diagnosticls.setup {
    filetypes = {
        'javascript',
        'javascriptreact',
        'typescript',
        'typescriptreact'
    },
    init_options = {
        filetypes = {
            javascript = 'eslint',
            javascriptreact = 'eslint',
            typescript = 'eslint',
            typescriptreact = 'eslint'
        },
        linters = {
            eslint = eslint
        }
    }
}
