return {
    { "nvim-lua/plenary.nvim", lazy = false },
    { "kyazdani42/nvim-web-devicons", lazy = false },

    { "rust-lang/rust.vim", ft = "rust" },
    { "togglebyte/togglerust", ft = "rust" },

    { "tpope/vim-sleuth", event = "BufReadPre" },
    { "tpope/vim-surround", event = "BufReadPost" },
    {
        "numToStr/Comment.nvim",
        config = true,
        event = "BufReadPost",
    },
    {
        "nvim-treesitter/nvim-treesitter-context",
        config = true,
        event = "BufReadPost",
    },
    {
        "Wansmer/treesj",
        config = true,
        event = "BufReadPost",
    },

    {
        "windwp/nvim-autopairs",
        config = { map_cr = true },
        event = "BufReadPost",
    },

    {
        "TimUntersberger/neogit",
        config = { disable_commit_confirmation = true },
        keys = {
            {
                "<leader>gs",
                function()
                    require("neogit").open()
                end,
            },
        },
    },
}
