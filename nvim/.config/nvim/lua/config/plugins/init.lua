return {
    {
        "yazeed1s/minimal.nvim",
        config = function()
            vim.cmd.colorscheme("minimal")
        end,
    },

    { "nvim-lua/plenary.nvim", event = { "VeryLazy", "BufReadPre" } },
    { "nvim-tree/nvim-web-devicons", event = { "VeryLazy", "BufReadPre" } },

    {
        "numToStr/Comment.nvim",
        config = true,
        event = { "VeryLazy", "BufReadPre" },
    },
}
