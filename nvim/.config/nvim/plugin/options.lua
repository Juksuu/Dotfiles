local opt = vim.opt

opt.cindent = true
opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4
opt.expandtab = true

opt.showcmd = true
opt.termguicolors = true
opt.laststatus = 3

opt.number = true
opt.relativenumber = true

opt.signcolumn = "yes"

opt.confirm = true
opt.scrolloff = 10
opt.showmode = false
opt.updatetime = 50

opt.smartcase = true
opt.incsearch = true
opt.hlsearch = false
opt.ignorecase = true
opt.inccommand = "split"

opt.splitright = true
opt.splitbelow = true

opt.completeopt = { "menuone", "noselect", "noinsert" }

opt.undofile = true
opt.swapfile = false
opt.shada = { "!", "'1000", "<50", "s10", "h" }

opt.list = true
opt.listchars = "tab:→ ,trail:·"
