local opt = vim.opt

opt.showcmd = true
opt.cmdheight = 1

opt.termguicolors = true

opt.number = true
opt.relativenumber = true

opt.guicursor = ""
opt.confirm = true
opt.scrolloff = 10
opt.showmode = false
opt.updatetime = 1500
opt.shortmess = opt.shortmess + "c"

opt.smartcase = true
opt.incsearch = true
opt.hlsearch = false
opt.ignorecase = true
opt.inccommand = "split"

opt.splitright = true
opt.splitbelow = true

opt.clipboard = "unnamedplus"
opt.completeopt = { "menuone", "noselect", "noinsert", "preview" }

opt.undofile = true

opt.list = true
opt.listchars = "tab:→ ,trail:·"

opt.formatoptions = opt.formatoptions
    - "t" -- Don't auto wrap code
    - "o" -- Don't continue comments with o and O
    + "n" -- Formatting numbered lists

vim.cmd([[
    autocmd FileType * set formatoptions-=o
]])
