local user_install_path = vim.fn.stdpath("data") ..
                              "/site/pack/user/opt/faerryn/user.nvim/default/default"
if vim.fn.isdirectory(user_install_path) == 0 then
    os.execute(
        [[git clone --depth 1 https://github.com/faerryn/user.nvim.git "]] ..
            user_install_path .. [["]])
end

vim.api.nvim_command("packadd faerryn/user.nvim/default/default")

local user = require('user')
user.setup()

local use = user.use

-- LuaFormatter off
use 'faerryn/user.nvim'

--- Utilities ---
use 'tpope/vim-surround'
use 'tpope/vim-fugitive'
use 'tpope/vim-commentary'
use 'ThePrimeagen/harpoon'
use 'maxbrunsfeld/vim-yankstack'
use 'editorconfig/editorconfig-vim'

-- snippets
use 'hrsh7th/vim-vsnip'
use 'hrsh7th/vim-vsnip-integ'
use "rafamadriz/friendly-snippets"

-- Dependencies
use 'nvim-lua/popup.nvim'
use 'nvim-lua/plenary.nvim'
use 'nvim-telescope/telescope-z.nvim'
use 'nvim-telescope/telescope-media-files.nvim'

use {
    'sbdchd/neoformat',
    config = require('plugin_configs.neoformat')
}

use {
    'nvim-lua/telescope.nvim',
    after = {
        'nvim-lua/popup.nvim',
        'nvim-lua/plenary.nvim',
        'kyazdani42/nvim-web-devicons',
        'nvim-telescope/telescope-z.nvim',
        'nvim-telescope/telescope-media-files.nvim',
    },
    config = require('plugin_configs.telescope')
}

use {
    'kyazdani42/nvim-tree.lua',
    after = 'kyazdani42/nvim-web-devicons',
    init = require('plugin_configs.nvimtree')
}

use {
    'hrsh7th/nvim-compe',
    config = require('plugin_configs.compe')
}

use {
    'ThePrimeagen/git-worktree.nvim',
    config = function() require('git-worktree').setup() end
}

use {
    'mizlan/iswap.nvim',
    after = 'nvim-treesitter/nvim-treesitter',
    config = function() require('iswap').setup{} end
}


--- LSP ---
use 'tjdevries/nlua.nvim'
use 'ray-x/lsp_signature.nvim'

use {
    'neovim/nvim-lspconfig',
    after = {
        'tjdevries/nlua.nvim',
        'ray-x/lsp_signature.nvim'
    },
    config = require('plugin_configs.lsp')
}

--- UI ---
use 'tjdevries/colorbuddy.nvim'
use 'kyazdani42/nvim-web-devicons'

use {
    'Juksuu/VibrantGrey',
    after = 'tjdevries/colorbuddy.nvim',
    -- repo = '~/code/colorschemes/VibrantGrey',
    config = require('plugin_configs.vibrantgrey')
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

--- LANGUAGES ---
use {
    'sheerun/vim-polyglot',
    config = require('plugin_configs.polyglot')
}

use {
    'nvim-treesitter/nvim-treesitter',
    config = require('plugin_configs.treesitter')
}

-- LuaFormatter on
user.flush()
