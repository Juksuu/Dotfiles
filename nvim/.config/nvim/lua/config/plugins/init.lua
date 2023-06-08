return {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",

    {
        "numToStr/Comment.nvim",
        config = true,
        event = { "VeryLazy", "BufReadPre" },
    },
}
