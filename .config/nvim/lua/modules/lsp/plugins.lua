local lsp = {}
local config = require('modules.lsp.config')

lsp['neovim/nvim-lspconfig'] = {
    event = "BufReadPre",
    config = config.lspconfig,
    requires = {
        'tjdevries/nlua.nvim',
        { 'nvim-lua/lsp-status.nvim', config = config.lspstatus }
    },
}

lsp['glepnir/lspsaga.nvim'] = {
    cmd = "Lspsaga",
    config = config.lspsaga
}

lsp['onsails/lspkind-nvim'] = {
    config = config.lspkind
}

return lsp
