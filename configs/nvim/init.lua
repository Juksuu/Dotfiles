vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.loader.enable()

require("disable_builtin")

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
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

require("lazy").setup("plugins", {
    dev = { path = "~/code/personal/nvim_plugins" },
    ui = {
        border = "rounded",
    },
    change_detection = {
        notify = false,
    },
})
