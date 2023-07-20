return {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",

    { "tpope/vim-sleuth", event = "BufReadPost" },
    { "lewis6991/gitsigns.nvim", config = true, event = "BufReadPost" },

    {
        "numToStr/Comment.nvim",
        config = true,
        event = { "VeryLazy", "BufReadPre" },
    },

    {
        "TimUntersberger/neogit",
        opts = { disable_commit_confirmation = true },
        keys = { { "<leader>gs", "<cmd>Neogit<CR>" } },
    },
}
