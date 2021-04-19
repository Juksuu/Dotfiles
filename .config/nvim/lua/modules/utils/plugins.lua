local utils = {}
local config = require('modules.utils.config')

utils['nvim-lua/telescope.nvim'] = {
    requires = {
        'kyazdani42/nvim-web-devicons',
        'nvim-lua/popup.nvim',
        'nvim-telescope/telescope-fzf-writer.nvim',
        { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' },
        { 'nvim-lua/plenary.nvim', config = config.plenary },
    },
    config = config.telescope
}

utils['kyazdani42/nvim-tree.lua'] = {
    requires = 'kyazdani42/nvim-web-devicons',
    config = config.nvimtree
}

utils['editorconfig/editorconfig-vim'] = {
    config = config.editorconfig
}

utils['prettier/vim-prettier'] = {
    event = 'BufWritePre'
}

utils['mbbill/undotree'] = {
    cmd = 'UndotreeToggle'
}

utils['godlygeek/tabular'] = {
    cmd = "Tabular"
}

utils['ThePrimeagen/harpoon'] = {}
utils['tpope/vim-repeat'] = {}
utils['tpope/vim-surround'] = {}
utils['tpope/vim-commentary'] = {}
utils['maxbrunsfeld/vim-yankstack'] = {}
utils['Raimondi/delimitMate'] = {}

return utils
