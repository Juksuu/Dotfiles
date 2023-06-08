return {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",

    { "lewis6991/gitsigns.nvim", config = true, event = "BufReadPre" },

    {
        "numToStr/Comment.nvim",
        config = true,
        event = { "VeryLazy", "BufReadPre" },
    },

    {
        "windwp/nvim-autopairs",
        opts = { map_bs = false, map_cr = false },
        event = "BufReadPost",
    },

    {
        "TimUntersberger/neogit",
        opts = { disable_commit_confirmation = true },
        keys = { { "<leader>gs", "<cmd>Neogit<CR>" } },
    },
}
