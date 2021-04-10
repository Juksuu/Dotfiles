-- Install packer if missing
if require('juksu.install_packer')() then
  return
end

-- Use space as leader key
vim.g.mapleader = " "

-- Load global functions
require("juksu.globals")

-- Load plugins
require('juksu.plugins')

-- Load neovim options
require('juksu.options')

-- Load global autocommands
require('juksu.autocommands')
