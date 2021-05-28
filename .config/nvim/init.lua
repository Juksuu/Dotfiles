-- Install Packer if not already installed
if require('juksu.init_packer')() then return end

-- Set leader key as soon as possible
vim.g.mapleader = " "

require('juksu.options')
require('juksu.plugins')
require('juksu.keymaps')
require('juksu.autocommands')
