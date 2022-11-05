return {
    {
        "catppuccin/nvim",
        as = "catppuccin",
        config = require("packages.theme.catppuccin"),
    },
    {
        "feline-nvim/feline.nvim",
        config = require("packages.theme.feline"),
    }
}
