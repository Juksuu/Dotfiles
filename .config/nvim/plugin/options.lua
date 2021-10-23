vim.g.loaded_matchparen = 1

local opt = vim.opt

opt.showcmd = true
opt.cmdheight = 1

opt.guicursor = ''
opt.syntax = 'on'
opt.confirm = true
opt.scrolloff = 10
opt.showmode = false
opt.cursorline = true
opt.updatetime = 500
opt.termguicolors = true
opt.shortmess = opt.shortmess + 'c'

opt.number = true
opt.relativenumber = true

opt.smartcase = true
opt.incsearch = true
opt.showmatch = true
opt.hlsearch = false
opt.ignorecase = true

opt.splitright = true
opt.splitbelow = true

opt.clipboard = 'unnamedplus'
opt.completeopt = {"menuone", "noselect", "noinsert", "preview"}

opt.undofile = true

opt.inccommand = 'split'

opt.tabstop = 4
opt.shiftwidth = 4
opt.softtabstop = 4
opt.expandtab = true
