return require("packer").startup(function(use)
    -- Packer can manage itself
    use("wbthomason/packer.nvim")

    use("nathom/filetype.nvim")

    use("nvim-lua/plenary.nvim")
    use("kyazdani42/nvim-web-devicons")

    use("tpope/vim-sleuth")
    use("ThePrimeagen/harpoon")

    use("rust-lang/rust.vim")
    use("togglebyte/togglerust")

    use({
        "sbdchd/neoformat",
        setup = require("plugin_configs.neoformat"),
    })

    use({
        "nvim-treesitter/nvim-treesitter",
        run = ":TSUpdate",
        config = require("plugin_configs.treesitter"),
    })

    use({
        "Juksuu/git-worktree.nvim",
        branch = "feature/select-base-branch",
        config = function()
            require("git-worktree").setup()
        end,
    })

    use({
        "TimUntersberger/neogit",
        config = require("plugin_configs.neogit"),
    })

    use({
        "nvim-telescope/telescope.nvim",
        requires = {
            "nvim-lua/popup.nvim",
            { "nvim-telescope/telescope-fzf-native.nvim", run = "make" },
        },
        after = "git-worktree.nvim",
        config = require("plugin_configs.telescope"),
    })

    use({
        "hrsh7th/nvim-cmp",
        requires = {
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-nvim-lua",

            "onsails/lspkind-nvim",

            {
                "L3MON4D3/LuaSnip",
                requires = "rafamadriz/friendly-snippets",
                config = require("plugin_configs.luasnip"),
            },
            "saadparwaiz1/cmp_luasnip",
        },
        config = require("plugin_configs.cmp"),
    })

    use("tjdevries/nlua.nvim")

    use({
        "neovim/nvim-lspconfig",
        after = "nlua.nvim",
        config = require("plugin_configs.lsp"),
    })

    use({
        "simrat39/rust-tools.nvim",
        after = "nvim-lspconfig",
        config = require("plugin_configs.rust_tools"),
    })

    --- Lazy loaded packages ---
    use({ "tpope/vim-surround", event = "BufRead" })
    use({ "AndrewRadev/splitjoin.vim", event = "BufRead" })
    use({ "maxbrunsfeld/vim-yankstack", event = "BufRead" })
    use({ "gpanders/editorconfig.nvim", event = "BufRead" })
    use({ "takac/vim-hardtime", event = "BufRead" })

    use({
        "numToStr/Comment.nvim",
        event = "BufRead",
        config = function()
            require("Comment").setup()
        end,
    })

    use({
        "kyazdani42/nvim-tree.lua",
        cmd = "NvimTreeToggle",
        config = require("plugin_configs.nvimtree"),
    })

    use({
        "lewis6991/gitsigns.nvim",
        event = "BufRead",
        config = function()
            require("gitsigns").setup()
        end,
    })

    use({
        "danymat/neogen",
        event = "BufRead",
        config = function()
            require("neogen").setup({
                enabled = true,
            })
        end,
    })
end)
