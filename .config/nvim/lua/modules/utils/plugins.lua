local utils = {}
local config = require('modules.utils.config')

-- LuaFormatter off

utils['nvim-lua/telescope.nvim'] = {
    requires = {
        'kyazdani42/nvim-web-devicons',
        'nvim-lua/popup.nvim',
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

utils['mbbill/undotree'] = {
    cmd = 'UndotreeToggle'
}

utils['godlygeek/tabular'] = {
    cmd = "Tabular"
}

utils['blackCauldron7/surround.nvim'] = {
    config = config.surround
}

utils['folke/lsp-trouble.nvim'] = {
    config = config.lsp_trouble,
    requires = "kyazdani42/nvim-web-devicons",
}

utils['folke/zen-mode.nvim'] = {
    config = config.zen_mode
}

utils['folke/todo-comments.nvim'] = {
   config = config.todo_comments
}

utils['npxbr/glow.nvim'] = {
    branch = 'main'
}

utils['sbdchd/neoformat'] = {}
utils['b3nj5m1n/kommentary'] = {}
utils['ThePrimeagen/harpoon'] = {}
utils['Raimondi/delimitMate'] = {}

-- LuaFormatter on
return utils
