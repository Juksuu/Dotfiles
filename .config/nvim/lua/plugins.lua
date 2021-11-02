-- LuaFormatter off

return require('packer').startup(function(use)
  --- Loaded in startup ---

  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  use 'nvim-lua/plenary.nvim'
  use 'kyazdani42/nvim-web-devicons'

  use 'tpope/vim-sleuth'

  use 'AndrewRadev/splitjoin.vim'
  use 'mtth/scratch.vim'

  use 'ThePrimeagen/harpoon'
  use {
    'ThePrimeagen/git-worktree.nvim',
    config = function() require('git-worktree').setup() end
  }

  use {
    'wuelnerdotexe/vim-enfocado',
    config = require('plugin_configs.enfocado')
  }

  use {
    'hoob3rt/lualine.nvim',
    config = require('plugin_configs.lualine')
  }

  use {
    'akinsho/bufferline.nvim',
    config = require('plugin_configs.bufferline')
  }

  use {
    'b0o/mapx.nvim',
    requires = 'folke/which-key.nvim'
  }

  use {
    'sbdchd/neoformat',
    setup = function() vim.g.neoformat_only_msg_on_error = 1 end
  }

  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
    config = require('plugin_configs.treesitter')
  }

  use {
    'nvim-treesitter/nvim-treesitter-refactor',
    after = 'nvim-treesitter'
  }

  use {
    'ms-jpq/coq_nvim',
    branch = 'coq',
    requires = {
      {'ms-jpq/coq.artifacts', branch = 'artifacts'},
      {'ms-jpq/coq.thirdparty', config = require('plugin_configs.coq_thirdparty')}
    },
    config = require('plugin_configs.coq')
  }

  --- Lazy loaded packages ---
  use {
    'sheerun/vim-polyglot',
    event = 'BufRead',
    config = require('plugin_configs.polyglot')
  }

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

  use {
    'nvim-lua/telescope.nvim',
    requires = {
      'nvim-lua/popup.nvim',
    },
    event = "VimEnter",
    config = require('plugin_configs.telescope')
  }

  use {
    'kyazdani42/nvim-tree.lua',
    cmd = 'NvimTreeToggle',
    config = require('plugin_configs.nvimtree')
  }

  -- Git
  use {
    'TimUntersberger/neogit',
    requires = {
      {
        'sindrets/diffview.nvim',
        event = 'BufRead',
        config = function() require('diffview').setup() end
      }
    },
    event = 'BufRead',
    config = require('plugin_configs.neogit')
  }

  -- LSP
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
    'https://gitlab.com/yorickpeterse/nvim-dd',
    event = 'BufRead',
    config = function() require('dd').setup({ timeout = 500 }) end
  }
  
  -- Theming
  use {
    'lewis6991/gitsigns.nvim',
    event = 'BufRead',
    config = function() require('gitsigns').setup() end
  }
end)
-- LuaFormatter on
