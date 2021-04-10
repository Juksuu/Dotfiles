-- Install packer if missing
if require('juksu.install_packer')() then
  return
end

-- Use space as leader key
vim.g.mapleader = " "

-- Load plugins
require('juksu.plugins')

-- Load global autocommands
require('juksu.autocommands')
