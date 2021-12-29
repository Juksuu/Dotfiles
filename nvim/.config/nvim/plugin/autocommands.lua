local utils = require("juksu.utils")

utils.create_autocommands({
    yank = {
        {
            "TextYankPost",
            [[* silent! lua vim.highlight.on_yank({higroup="IncSearch", timeout=400})]],
        },
    },
})
