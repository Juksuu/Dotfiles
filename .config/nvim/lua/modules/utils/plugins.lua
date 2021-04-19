local utils = {}
local config = require('modules.utils.config')

utils['nvim-lua/telescope.nvim'] = {
    requires = {
        'kyazdani42/nvim-web-devicons',
        'nvim-lua/popup.nvim',
        {'nvim-lua/plenary.nvim', config = config.plenary },
        'nvim-telescope/telescope-fzf-writer.nvim',
        { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
    },
    config = config.telescope
}

utils['kyazdani42/nvim-tree.lua'] = {
    cmd = { 'NvimTreeToggle', 'NvimTreeOpen' },
    requires = 'kyazdani42/nvim-web-devicons',
    config = config.nvimtree
}

utils['editorconfig/editorconfig-vim'] = {
    config = config.editorconfig
}

utils['ThePrimeagen/harpoon'] = {}
utils['prettier/vim-prettier'] = {}
utils['tpope/vim-repeat'] = {}
utils['tpope/vim-surround'] = {}
utils['tpope/vim-commentary'] = {}
utils['godlygeek/tabular'] = {}
utils['maxbrunsfeld/vim-yankstack'] = {}
utils['Raimondi/delimitMate'] = {}
utils['mbbill/undotree'] = {}

return utils
