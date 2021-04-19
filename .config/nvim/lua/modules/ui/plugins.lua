local ui = {}
local config = require('modules.ui.config')

ui['mhinz/vim-signify'] = {}

ui['norcalli/nvim-colorizer.lua'] = { 
    config = config.colorizer
}

ui['tjdevries/cyclist.vim'] = {
    config = config.cyclist
}

ui['tjdevries/gruvbuddy.nvim'] = {
    config = config.gruvbuddy,
    requires = 'tjdevries/colorbuddy.nvim'
}

-- ui['ntk148v/vim-horizon'] = { }

return ui
