return {
    -- Nvim packages to have by default
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",

    { "Bilal2453/luvit-meta", lazy = true }, -- optional `vim.uv` typings
    {
        "folke/lazydev.nvim",
        ft = "lua", -- only load on lua files
        opts = {
            library = {
                -- See the configuration section for more details
                -- Load luvit types when the `vim.uv` word is found
                { path = "luvit-meta/library", words = { "vim%.uv" } },
            },
        },
    },

    -- Language/tooling support
    "direnv/direnv.vim",

    { "tpope/vim-sleuth", event = "VeryLazy" },
    { "aserowy/tmux.nvim", config = true, event = "VeryLazy" },
    { "echasnovski/mini.pairs", config = true, event = "VeryLazy" },
    { "lewis6991/gitsigns.nvim", config = true, event = "VeryLazy" },

    {
        "Juksuu/worktrees.nvim",
        event = "VeryLazy",
        config = true,
        -- name = "worktrees",
        -- dir = "~/code/worktrees.nvim/main",
    },

    {
        "NeogitOrg/neogit",
        opts = { disable_commit_confirmation = true },
        keys = { { "<leader>gs", "<cmd>Neogit<CR>" } },
    },

    {
        "j-hui/fidget.nvim",
        config = true,
        event = "LspAttach",
    },
}
