return require('packer').startup(function(use)
    use 'wbthomason/packer.nvim'

    --- UTILITIES ---
    use 'npxbr/glow.nvim'
    use 'sbdchd/neoformat'
    use 'tpope/vim-surround'
    use 'tpope/vim-fugitive'
    use 'b3nj5m1n/kommentary'
    use 'ThePrimeagen/harpoon'
    use 'editorconfig/editorconfig-vim'
    use 'maxbrunsfeld/vim-yankstack'

    use {
        'nvim-lua/telescope.nvim',
        requires = {
            'nvim-lua/popup.nvim', 'nvim-lua/plenary.nvim',
            'kyazdani42/nvim-web-devicons'
        }
    }

    use {
        'kyazdani42/nvim-tree.lua',
        requires = {'kyazdani42/nvim-web-devicons'},
        config = require('plugin_configs.nvimtree')
    }

    use {'hrsh7th/nvim-compe', config = require('plugin_configs.compe')}

    use {
        'ThePrimeagen/git-worktree.nvim',
        config = function() require('git-worktree').setup() end
    }

    --- LSP ---
    use {
        'neovim/nvim-lspconfig',
        requires = {'tjdevries/nlua.nvim'},
        config = require('plugin_configs.lsp')
    }

    --- UI ---
    use {
        'lewis6991/gitsigns.nvim',
        config = function() require('gitsigns').setup() end
    }

    use {
        'norcalli/nvim-colorizer.lua',
        config = function() require('colorizer').setup() end
    }

    use {
        'Juksuu/VibrantGrey',
        requires = {'tjdevries/colorbuddy.nvim'},
        config = require('plugin_configs.vibrantgrey')
    }

    --- LANGUAGES ---
    use {'sheerun/vim-polyglot', config = require('plugin_configs.polyglot')}

    use {
        'nvim-treesitter/nvim-treesitter',
        config = require('plugin_configs.treesitter')
    }

end)
