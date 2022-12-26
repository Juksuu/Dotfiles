return {
    "nvim-lua/plenary.nvim",

    { "maxbrunsfeld/vim-yankstack", lazy = false },
    { "kyazdani42/nvim-web-devicons", lazy = false },

    { "tpope/vim-surround", event = "BufReadPost"},
    { "gpanders/editorconfig.nvim", event = "BufReadPre" },

    { "numToStr/Comment.nvim", config = true, event = "BufReadPost" },
    { "nmac427/guess-indent.nvim", config = true, event = "BufReadPre" },
    { "nvim-treesitter/nvim-treesitter-context", config = true, event = "BufReadPre" },

    { "windwp/nvim-autopairs", config = { map_cr = true}, event = "BufReadPost" },

    { "TimUntersberger/neogit", config = true, keys = {
        {
            "<leader>gs",
            function() require("neogit").open() end
        },
    },
}
}
