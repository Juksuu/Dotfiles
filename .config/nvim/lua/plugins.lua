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
     },
     after = 'git-worktree.nvim',
     config = require('plugin_configs.telescope')
  }

  use {
     'kyazdani42/nvim-tree.lua',
     requires = 'kyazdani42/nvim-web-devicons',
     init = require('plugin_configs.nvimtree')
  }
  
  use {
      'ms-jpq/coq_nvim',
      branch = 'coq',
      requires = {
         'ms-jpq/coq.artifacts',
         branch = 'artifacts'
      },
      config = require('plugin_configs.coq')
  }

  use {
     'mizlan/iswap.nvim',
     config = function() require('iswap').setup{} end
  }

  -- Git
  use {
      'ThePrimeagen/git-worktree.nvim',
      config = function() require('git-worktree').setup() end
  }

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
        'tjdevries/nlua.nvim'
     },
     after = 'coq_nvim',
     config = require('plugin_configs.lsp')
  }

  use {
     'simrat39/rust-tools.nvim',
     after = 'nvim-lspconfig',
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
     'rrethy/vim-hexokinase',
     init = function() vim.g.Hexokinase_higlighters = { 'virtual' } end,
     run = 'make hexokinase'
  }

  use {
      'famiu/feline.nvim',
      config = require('plugin_configs.feline')
  }

end)
-- LuaFormatter on
