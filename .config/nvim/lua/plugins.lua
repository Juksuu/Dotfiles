-- LuaFormatter off

vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  -- Packer can manage itself
  use {
    'wbthomason/packer.nvim',
    event = 'VimEnter'
  }

  --- LANGUAGES ---
  use {
    'sheerun/vim-polyglot',
    event = 'BufRead',
    config = require('plugin_configs.polyglot')
  }

  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
    event = 'BufRead',
    config = require('plugin_configs.treesitter')
  }

  --- Utilities ---
  use {
    'tpope/vim-surround',
    event = 'BufRead'
  }

  use {
    'tpope/vim-commentary',
    event = 'BufRead'
  }

  use {
    'maxbrunsfeld/vim-yankstack',
    event = 'BufRead'
  }

  use {
    'editorconfig/editorconfig-vim',
    event = 'BufRead'
  }

  -- Dependencies
  use {
    'nvim-lua/plenary.nvim',
    after = 'packer.nvim',
  }

  use {
    'ThePrimeagen/harpoon',
    after = 'plenary.nvim'
  }

  use {
    'kyazdani42/nvim-web-devicons',
    event = 'BufRead'
  }

  use {
    'Darazaki/indent-o-matic',
    event = 'BufRead',
    config = require('plugin_configs.indentmatic')
  }

  use {
    'sbdchd/neoformat',
    setup = require('plugin_configs.neoformat')
  }

  use {
    'nvim-lua/telescope.nvim',
    requires = {
      'nvim-lua/popup.nvim',
    },
    after = {
      'git-worktree.nvim',
      'plenary.nvim',
      'nvim-web-devicons'
    },
    config = require('plugin_configs.telescope')
  }

  use {
    'kyazdani42/nvim-tree.lua',
    cmd = 'NvimTreeToggle',
    config = require('plugin_configs.nvimtree')
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

  -- Git
  use {
    'ThePrimeagen/git-worktree.nvim',
    after = 'plenary.nvim',
    config = function() require('git-worktree').setup() end
  }

  use {
    'TimUntersberger/neogit',
    requires = {
      {
        'sindrets/diffview.nvim',
        event = 'BufRead',
        config = function() require('diffview').setup() end
      }
    },
    after = 'plenary.nvim',
    config = require('plugin_configs.neogit')
  }

  --- LSP ---
  use {
    'tjdevries/nlua.nvim',
    event = 'BufRead'
  }

  use {
    'neovim/nvim-lspconfig',
    after = 'nlua.nvim',
    config = require('plugin_configs.lsp')
  }

  use {
    'simrat39/rust-tools.nvim',
    after = 'nvim-lspconfig',
    config = require('plugin_configs.rust_tools')
  }
  
  use {
    'EdenEast/nightfox.nvim',
    event = 'BufRead',
    config = require('plugin_configs.nightfox')
  }

  use {
    'lewis6991/gitsigns.nvim',
    after = 'plenary.nvim',
    config = function() require('gitsigns').setup() end
  }

  use {
    'hoob3rt/lualine.nvim',
    event = 'BufRead',
    config = require('plugin_configs.lualine')
  }

  use {
    'akinsho/bufferline.nvim',
    event = 'BufRead',
    config = require('plugin_configs.bufferline')
  }

end)
-- LuaFormatter on
