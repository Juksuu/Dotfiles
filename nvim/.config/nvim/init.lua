vim.g.mapleader = " "
vim.g.maplocalleader = " "

require("config.disable_builtin")

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "--single-branch",
        "git@github.com:folke/lazy.nvim.git",
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup("config.plugins", {
    dev = { path = "~/code/personal/nvim_plugins" },
    install = {
        missing = false,
    },
})
