-- LuaFormatter off
return require('packer').startup(function()
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  --- LANGUAGES ---
  use {
     'sheerun/vim-polyglot',
     config = require('plugin_configs.polyglot')
  }

  use {
     'nvim-treesitter/nvim-treesitter',
     run = ':TSUpdate',
     config = require('plugin_configs.treesitter')
  }

  --- Utilities ---
  use 'tpope/vim-surround'
  use 'tpope/vim-commentary'
  use 'ThePrimeagen/harpoon'
  use 'maxbrunsfeld/vim-yankstack'
  use 'editorconfig/editorconfig-vim'

  -- snippets
  use {
     'hrsh7th/vim-vsnip',
     requires = {
        'hrsh7th/vim-vsnip-integ',
        'rafamadriz/friendly-snippets'
     }
  }

  -- Dependencies
  use {
     'sbdchd/neoformat',
     config = require('plugin_configs.neoformat')
  }

  use {
     'nvim-lua/telescope.nvim',
     requires = {
        'nvim-lua/popup.nvim',
        'nvim-lua/plenary.nvim',
        'kyazdani42/nvim-web-devicons',
        {
           'ThePrimeagen/git-worktree.nvim',
           config = function() require('git-worktree').setup() end
        }
     },
     config = require('plugin_configs.telescope')
  }

  use {
     'kyazdani42/nvim-tree.lua',
     requires = 'kyazdani42/nvim-web-devicons',
     init = require('plugin_configs.nvimtree')
  }

  use {
     'hrsh7th/nvim-compe',
     config = require('plugin_configs.compe')
  }

  use {
     'mizlan/iswap.nvim',
     config = function() require('iswap').setup{} end
  }

  -- Git
  use {
     'TimUntersberger/neogit',
     requires = {
        {
           'sindrets/diffview.nvim',
           config = function() require('diffview').setup() end
        }
     },
     config = require('plugin_configs.neogit')
  }

  --- LSP ---
  use {
     'neovim/nvim-lspconfig',
     requires = {
        'tjdevries/nlua.nvim',
        'ray-x/lsp_signature.nvim'
     },
     config = require('plugin_configs.lsp')
  }

  use {
     'simrat39/rust-tools.nvim',
     config = require('plugin_configs.rust_tools')
  }

  --- UI ---
  use {
     'RRethy/nvim-base16',
     config = require('plugin_configs.base16')
  }

  use {
     'xiyaowong/nvim-transparent',
     config = require('plugin_configs.transparent')
  }

  use {
     'lewis6991/gitsigns.nvim',
     config = function() require('gitsigns').setup() end
  }

  use {
     'norcalli/nvim-colorizer.lua',
     config = function() require('colorizer').setup() end
  }

  use {
     'hoob3rt/lualine.nvim',
     config = require('plugin_configs.lualine')
  }

end)
-- LuaFormatter on
