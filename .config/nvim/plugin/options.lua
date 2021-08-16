local opt = vim.opt

opt.guicursor = ''
opt.syntax = 'on'
opt.confirm = true
opt.showmode = true
opt.termguicolors = true
opt.shortmess = opt.shortmess + 'c'

opt.number = true
opt.relativenumber = true

opt.smartcase = true
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
