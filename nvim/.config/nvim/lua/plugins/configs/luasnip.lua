return function()
    require("luasnip").config.set_config({
        history = true,
    })
    require("luasnip/loaders/from_vscode").lazy_load({
        paths = {
            "~/.local/share/nvim/site/pack/packer/start/friendly-snippets",
        },
    })

    local utils = require("juksu.utils")

    utils.map("n", "<C-h>", "<cmd> lua require('luasnip').jump(-1)<CR>")
    utils.map("n", "<C-l>", "<cmd> lua require('luasnip').jump(1)<CR>")
    utils.map("s", "<C-h>", "<cmd> lua require('luasnip').jump(-1)<CR>")
    utils.map("s", "<C-l>", "<cmd> lua require('luasnip').jump(1)<CR>")
    utils.map(
        "i",
        "<C-h>",
        "<cmd> lua require('luasnip').jump(-1)<CR>",
        { noremap = false }
    )
    utils.map(
        "i",
        "<C-l>",
        "<cmd> lua require('luasnip').jump(1)<CR>",
        { noremap = false }
    )
end
