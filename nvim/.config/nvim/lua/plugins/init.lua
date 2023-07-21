return {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",

    { "tpope/vim-sleuth", event = "VeryLazy" },
    { "numToStr/Comment.nvim", config = true, event = "VeryLazy" },
    { "echasnovski/mini.pairs", config = true, event = "VeryLazy" },
    { "lewis6991/gitsigns.nvim", config = true, event = "VeryLazy" },

    {
        "TimUntersberger/neogit",
        opts = { disable_commit_confirmation = true },
        keys = { { "<leader>gs", "<cmd>Neogit<CR>" } },
    },
}
