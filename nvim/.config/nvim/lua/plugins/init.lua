local packer_bootstrap = false
local install_path = vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
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
        use("nvim-lua/plenary.nvim")
        use("kyazdani42/nvim-web-devicons")
        use({ "tpope/vim-surround", event = "BufRead" })
        use({ "gpanders/editorconfig.nvim", event = "BufRead" })
        use({ "maxbrunsfeld/vim-yankstack", event = "BufRead" })

        use({
            "nmac427/guess-indent.nvim",
            config = function()
                require("guess-indent").setup()
            end,
        })

        use({
            "Juksuu/worktrees.nvim",
            config = function()
                require("worktrees").setup()
            end,
        })

        use({
            "numToStr/Comment.nvim",
            event = "BufRead",
            config = function()
                require("Comment").setup()
            end,
        })

        use({
            "catppuccin/nvim",
            as = "catppuccin",
            config = require("plugins.configs.catppuccin"),
        })

        use({
            "feline-nvim/feline.nvim",
            config = require("plugins.configs.feline"),
        })

        -- use({
        --     "sbdchd/neoformat",
        --     setup = require("plugins.configs.neoformat"),
        -- })

        use({
            "nvim-treesitter/nvim-treesitter",
            config = require("plugins.configs.treesitter"),
        })

        use({
            "nvim-treesitter/nvim-treesitter-context",
            after = "nvim-treesitter",
            config = require("plugins.configs.treesitter-context"),
        })

        use({
            "windwp/nvim-autopairs",
            config = require("plugins.configs.autopairs"),
        })

        -- Git
        use({
            "TimUntersberger/neogit",
            config = require("plugins.configs.neogit"),
        })

        use({
            "lewis6991/gitsigns.nvim",
            event = "BufRead",
            config = require("plugins.configs.gitsigns"),
        })

        -- Fuzzy find
        use({
            "nvim-telescope/telescope.nvim",
            requires = {
                "nvim-lua/popup.nvim",
                "nvim-telescope/telescope-file-browser.nvim",
                "nvim-telescope/telescope-fzy-native.nvim",
            },
            after = "worktrees.nvim",
            config = require("plugins.configs.telescope"),
        })

        -- Completion
        use({
            "hrsh7th/nvim-cmp",
            requires = {
                "hrsh7th/cmp-path",
                "hrsh7th/cmp-buffer",
                "hrsh7th/cmp-nvim-lsp",
                "hrsh7th/cmp-nvim-lua",
                "lukas-reineke/cmp-rg",
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
        use({
            "williamboman/mason.nvim",
            config = function()
                require("mason").setup()
            end,
        })

        use({
            "williamboman/mason-lspconfig.nvim",
            requires = "neovim/nvim-lspconfig",
            after = "mason.nvim",
            config = require("lsp"),
        })

        use({
            "j-hui/fidget.nvim",
            after = "mason-lspconfig.nvim",
            config = function()
                require("fidget").setup({
                    window = {
                        relative = "editor",
                        blend = 0,
                    },
                })
            end,
        })

        use({
            "weilbith/nvim-code-action-menu",
            after = "mason-lspconfig.nvim",
            config = require("plugins.configs.codeaction"),
        })

        use({
            "jayp0521/mason-null-ls.nvim",
            requires = "jose-elias-alvarez/null-ls.nvim",
            after = "mason.nvim",
            config = require("plugins.configs.null-ls"),
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
