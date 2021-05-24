local ui = {}
local config = require('modules.ui.config')

ui['lewis6991/gitsigns.nvim'] = {config = config.gitsigns}

ui['norcalli/nvim-colorizer.lua'] = {config = config.colorizer}

ui['hoob3rt/lualine.nvim'] = {config = config.lualine}

--[[ ui['folke/tokyonight.nvim'] = {
    config = config.tokyonight
} ]]

ui['Juksuu/VibrantGrey'] = {
    config = config.vibrantgrey,
    requires = "tjdevries/colorbuddy.nvim"
}

ui['tjdevries/cyclist.vim'] = {}

return ui
