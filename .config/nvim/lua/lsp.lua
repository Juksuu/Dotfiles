local nvim_lsp = require "lspconfig"
local saga = require "lspsaga"

vim.g.completion_matching_smart_case = 1
vim.g.completion_matching_strategy_list = {"exact", "substring"}

saga.init_lsp_saga()

local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Completion
  require'completion'.on_attach(client)

  -- Mappings.
  local opts = { noremap=true, silent=true }

  -- Set some keybinds conditional on server capabilities
  if client.resolved_capabilities.document_formatting then
    buf_set_keymap("n", "<space>cF", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
  elseif client.resolved_capabilities.document_range_formatting then
    buf_set_keymap("n", "<space>cF", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
  end

end

-- Use a loop to conveniently both setup defined servers
-- and map buffer local keybindings when the language server attaches
local servers = { "pyls", "tsserver" }
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup { on_attach = on_attach }
end

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
