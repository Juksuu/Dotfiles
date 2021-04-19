local ui = {}
local config = require('modules.ui.config')

ui['mhinz/vim-signify'] = {}

ui['norcalli/nvim-colorizer.lua'] = { 
    config = config.colorizer
}

ui['tjdevries/gruvbuddy.nvim'] = {
    config = config.gruvbuddy,
    requires = 'tjdevries/colorbuddy.nvim'
}

ui['hoob3rt/lualine.nvim'] = {
    config = config.lualine
}

ui['tjdevries/cyclist.vim'] = {}

-- ui['ntk148v/vim-horizon'] = { }

return ui
