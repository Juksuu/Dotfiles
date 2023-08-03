vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true

vim.opt.hlsearch = false
vim.opt.incsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.termguicolors = true

vim.opt.number = true
vim.opt.laststatus = 3
vim.opt.showtabline = 0
vim.opt.signcolumn = "yes:1"
vim.opt.statuscolumn = " %=%l %s%C%#StatusColumnBorder#▕%#None# "

vim.opt.list = true
vim.opt.listchars = "tab:→ ,trail:·"
vim.opt.fillchars = {
    horiz = "─",
    horizup = "─",
    horizdown = "─",
    vert = "▏",
    vertleft = "▏",
    vertright = "▕",
    verthoriz = "─",
    eob = " ",
    diff = "╱",
}

vim.opt.undofile = true
vim.opt.swapfile = false

vim.opt.confirm = true
vim.opt.updatetime = 100

vim.opt.scrolloff = 10
vim.opt.smoothscroll = true
