return {
    { "nvim-lua/plenary.nvim", event = { "VeryLazy", "BufReadPre" } },
    { "nvim-tree/nvim-web-devicons", event = { "VeryLazy", "BufReadPre" } },
    { "tpope/vim-sleuth", event = "BufReadPost" },
    { "tpope/vim-surround", event = "BufReadPost" },
    { "weilbith/nvim-code-action-menu", cmd = "CodeActionMenu" },
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
        opts = { use_default_keymaps = false },
        keys = { { "<leader>j", "<cmd>TSJToggle<CR>" } },
    },
    {
        "mvllow/modes.nvim",
        config = true,
        event = "BufReadPost",
    },
    {
        "windwp/nvim-autopairs",
        opts = { map_cr = true },
        event = "BufReadPost",
    },
    {
        "TimUntersberger/neogit",
        opts = { disable_commit_confirmation = true },
        keys = { { "<leader>gs", "<cmd>Neogit<CR>" } },
    },
    {
        "gbprod/yanky.nvim",
        config = true,
        keys = {
            { "p", "<Plug>(YankyPutAfter)" },
            { "P", "<Plug>(YankyPutBefore)" },
            { "gp", "<Plug>(YankyGPutAfter)" },
            { "gP", "<Plug>(YankyGPutBefore)" },
            { "<m-n>", "<Plug>(YankyCycleForward)" },
            { "<m-p>", "<Plug>(YankyCycleBackward)" },
            { "<m-p>", "<Plug>(YankyCycleBackward)" },
        },
    },
}
