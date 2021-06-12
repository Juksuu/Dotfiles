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

use 'faerryn/user.nvim'

--- Utilities ---
use 'tpope/vim-surround'
use 'tpope/vim-fugitive'
use 'b3nj5m1n/kommentary'
use 'nvim-lua/popup.nvim'
use 'ThePrimeagen/harpoon'
use 'nvim-lua/plenary.nvim'
use 'maxbrunsfeld/vim-yankstack'
use 'editorconfig/editorconfig-vim'

use {'sbdchd/neoformat', config = require('plugin_configs.neoformat')}

use {
    'nvim-lua/telescope.nvim',
    after = {
        'nvim-lua/popup.nvim', 'nvim-lua/plenary.nvim',
        'kyazdani42/nvim-web-devicons'
    },
    config = require('plugin_configs.telescope')
}

use {
    'kyazdani42/nvim-tree.lua',
    after = 'kyazdani42/nvim-web-devicons',
    config = require('plugin_configs.nvimtree')
}

use {'hrsh7th/nvim-compe', config = require('plugin_configs.compe')}

use {
    'ThePrimeagen/git-worktree.nvim',
    config = function() require('git-worktree').setup() end
}

--- LSP ---
use 'tjdevries/nlua.nvim'
use {
    'neovim/nvim-lspconfig',
    after = 'tjdevries/nlua.nvim',
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

use {'hoob3rt/lualine.nvim', config = require('plugin_configs.lualine')}

--- LANGUAGES ---
use {'sheerun/vim-polyglot', config = require('plugin_configs.polyglot')}

use {
    'nvim-treesitter/nvim-treesitter',
    config = require('plugin_configs.treesitter')
}

user.flush()
