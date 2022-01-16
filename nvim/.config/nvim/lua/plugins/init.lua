local packer_bootstrap = false

local install_path = vim.fn.stdpath("data")
    .. "/site/pack/packer/start/packer.nvim"
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    packer_bootstrap = true
    vim.fn.system({
        "git",
        "clone",
        "--depth",
        "1",
        "https://github.com/wbthomason/packer.nvim",
        install_path,
    })
end

vim.cmd([[ packadd packer.nvim ]])

local packer = require("packer")
return packer.startup({
    function(use)
        -- Packer can manage itself
        use("wbthomason/packer.nvim")

        -- Impatient for lua module optimizations
        use("lewis6991/impatient.nvim")

        -- Languages
        use("DingDean/wgsl.vim")
        use({ "rust-lang/rust.vim", ft = "rust" })
        use({ "togglebyte/togglerust", ft = "rust" })

        -- Utils
        use("tpope/vim-sleuth")
        use("nvim-lua/plenary.nvim")
        use("kyazdani42/nvim-web-devicons")
        use({ "tpope/vim-surround", event = "BufRead" })
        use({ "takac/vim-hardtime", event = "BufRead" })
        use({ "AndrewRadev/splitjoin.vim", event = "BufRead" })
        use({ "gpanders/editorconfig.nvim", event = "BufRead" })

        use({
            "catppuccin/nvim",
            as = "catppuccin",
            config = require("plugins.configs.catppuccin"),
        })

        use({
            "feline-nvim/feline.nvim",
            config = require("plugins.configs.feline"),
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
            "ThePrimeagen/harpoon",
            config = require("plugins.configs.harpoon"),
        })

        use({
            "bfredl/nvim-miniyank",
            config = require("plugins.configs.miniyank"),
        })

        use({
            "windwp/nvim-autopairs",
            event = "BufRead",
            config = require("plugins.configs.autopairs"),
        })

        use({
            "numToStr/Comment.nvim",
            event = "BufRead",
            config = function()
                require("Comment").setup()
            end,
        })

        use({
            "danymat/neogen",
            event = "BufRead",
            config = require("plugins.configs.neogen"),
        })

        -- Git
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
            "lewis6991/gitsigns.nvim",
            event = "BufRead",
            config = function()
                require("gitsigns").setup()
            end,
        })

        -- Fuzzy find
        use({
            "nvim-telescope/telescope.nvim",
            requires = {
                "nvim-lua/popup.nvim",
                "nvim-telescope/telescope-file-browser.nvim",
                { "nvim-telescope/telescope-fzf-native.nvim", run = "make" },
            },
            after = "git-worktree.nvim",
            config = require("juksu.telescope"),
        })

        -- Completion
        use({
            "hrsh7th/nvim-cmp",
            requires = {
                "hrsh7th/cmp-path",
                "hrsh7th/cmp-buffer",
                "hrsh7th/cmp-nvim-lsp",
                "hrsh7th/cmp-nvim-lua",
                "lukas-reineke/cmp-under-comparator",

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

        -- Lsp
        use("tjdevries/nlua.nvim")
        use("simrat39/rust-tools.nvim")

        use({
            "neovim/nvim-lspconfig",
            after = "nlua.nvim",
            config = require("lsp"),
        })

        use({
            "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
            after = "nvim-lspconfig",
            config = require("plugins.configs.lsplines"),
        })

        if packer_bootstrap then
            packer.sync()
        end
    end,
    config = {
        display = {
            open_fn = function()
                return require("packer.util").float({ border = "single" })
            end,
            prompt_border = "single",
        },
        compile_path = vim.fn.stdpath("config") .. "/lua/packer_compiled.lua",
    },
})
