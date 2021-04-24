local ui = {}
local config = require('modules.ui.config')

ui['mhinz/vim-signify'] = {}

ui['norcalli/nvim-colorizer.lua'] = { 
    config = config.colorizer
}

ui['folke/tokyonight.nvim'] = {
    config = config.tokyonight
}

ui['hoob3rt/lualine.nvim'] = {
    config = config.lualine
}

ui['tjdevries/cyclist.vim'] = {}

return ui
