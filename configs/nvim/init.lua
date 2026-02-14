vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.loader.enable()

require("vim._core.ui2").enable({
    enable = true,
    msg = {
        target = "msg",
    },
})

require("disable_builtin")
require("plugins")
