vim.g.do_filetype_lua = 1
vim.g.did_load_filetypes = 0

vim.g.mapleader = " "

pcall(require, "impatient")
require("plugins")
