-- Install packer if missing
if require('juksu.install_packer')() then
  return
end

-- Use space as leader key
vim.g.mapleader = " "

-- Load global functions
require('juksu.globals')

-- Load neovim options
require('juksu.options')

-- Load plugins
require('juksu.plugins')

-- Force loading of astronauta first.
vim.cmd [[runtime plugin/astronauta.vim]]

-- Load global autocommands
require('juksu.autocommands')

-- Setup lsp
require('juksu.lsp')

-- Setup telescope
require("juksu.telescope")
require("juksu.telescope.mappings")
