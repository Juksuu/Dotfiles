local lsp = {}
local config = require('modules.lsp.config')

lsp['neovim/nvim-lspconfig'] = {
    config = config.lspconfig,
    requires = {
        'tjdevries/nlua.nvim',
        { 'nvim-lua/lsp-status.nvim', config = config.lspstatus }
    },
}

lsp['glepnir/lspsaga.nvim'] = {
    config = config.lspsaga
}

return lsp
