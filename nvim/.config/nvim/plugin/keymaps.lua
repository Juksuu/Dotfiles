local utils = require("juksu.utils")

vim.g.mapleader = " "

-- Reselect visual selection after indenting
utils.map("v", "<", "<gv")
utils.map("v", ">", ">gv")

-- Maintain cursor position when yanking a visual selection
utils.map("v", "y", "myy`y")
utils.map("v", "Y", "myY`y")

-- Move visual selection with J and K
utils.map("v", "J", ":m '>+1<CR>gv=gv")
utils.map("v", "K", ":m '<-2<CR>gv=gv")
