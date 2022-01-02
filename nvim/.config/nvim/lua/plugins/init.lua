local present, packer = pcall(require, "plugins.initpacker")

if not present then
    return false
end

return packer.startup(function(use)
    -- Packer can manage itself
    use("wbthomason/packer.nvim")

    --- Loaded on startup ---
    use("tpope/vim-sleuth")
    use("nvim-lua/plenary.nvim")
    use("kyazdani42/nvim-web-devicons")

    -- Languages
    use("DingDean/wgsl.vim")

    use({
        "luisiacc/gruvbox-baby",
        config = require("plugins.configs.gruvbox"),
    })

    use({
        "sbdchd/neoformat",
        setup = require("plugins.configs.neoformat"),
    })

    use({
        "nvim-treesitter/nvim-treesitter",
        run = ":TSUpdate",
        config = require("plugins.configs.treesitter"),
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
        config = require("plugins.configs.neogit"),
    })

    use({
        "nvim-telescope/telescope.nvim",
        requires = {
            "nvim-lua/popup.nvim",
            { "nvim-telescope/telescope-fzf-native.nvim", run = "make" },
        },
        after = "git-worktree.nvim",
        config = require("juksu.telescope"),
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
                config = require("plugins.configs.luasnip"),
            },
            "saadparwaiz1/cmp_luasnip",
        },
        config = require("plugins.configs.cmp"),
    })

    use("tjdevries/nlua.nvim")

    use({
        "neovim/nvim-lspconfig",
        after = "nlua.nvim",
        config = require("lsp"),
    })

    use({
        "simrat39/rust-tools.nvim",
        after = "nvim-lspconfig",
        config = require("plugins.configs.rust_tools"),
    })

    --- Lazy loaded packages ---
    use({ "tpope/vim-surround", event = "BufRead" })
    use({ "takac/vim-hardtime", event = "BufRead" })
    use({ "AndrewRadev/splitjoin.vim", event = "BufRead" })
    use({ "maxbrunsfeld/vim-yankstack", event = "BufRead" })
    use({ "gpanders/editorconfig.nvim", event = "BufRead" })

    use({
        "ThePrimeagen/harpoon",
        event = "BufRead",
        config = require("plugins.configs.harpoon"),
    })

    use({
        "numToStr/Comment.nvim",
        event = "BufRead",
        config = function()
            require("Comment").setup()
        end,
    })

    use({
        "kyazdani42/nvim-tree.lua",
        event = "BufRead",
        config = require("plugins.configs.nvimtree"),
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
        config = require("plugins.configs.neogen"),
    })

    -- Languages
    use({ "rust-lang/rust.vim", ft = "rust" })
    use({ "togglebyte/togglerust", ft = "rust" })
end)
