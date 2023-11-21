return {
    "direnv/direnv.vim",
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",

    { "tpope/vim-sleuth", event = "VeryLazy" },
    { "aserowy/tmux.nvim", config = true, event = "VeryLazy" },
    { "numToStr/Comment.nvim", config = true, event = "VeryLazy" },
    { "echasnovski/mini.pairs", config = true, event = "VeryLazy" },
    { "lewis6991/gitsigns.nvim", config = true, event = "VeryLazy" },

    {
        "NeogitOrg/neogit",
        opts = { disable_commit_confirmation = true },
        keys = { { "<leader>gs", "<cmd>Neogit<CR>" } },
    },

    {
        "windwp/windline.nvim",
        config = function()
            require("wlsample.vscode")
        end,
    },
    {
        "j-hui/fidget.nvim",
        config = true,
        tag = "legacy",
        event = "LspAttach",
    },
}
