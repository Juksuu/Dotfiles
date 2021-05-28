return require('packer').startup(function(use)
    use 'wbthomason/packer.nvim'

    -- Utilities
    use 'b3nj5m1n/kommentary'
    use 'sbdchd/neoformat'

    use {
        'nvim-lua/telescope.nvim',
        requires = {
            'nvim-lua/popup.nvim', 'nvim-lua/plenary.nvim',
            'kyazdani42/nvim-web-devicons'
        }
    }

    use {
        'kyazdani42/nvim-tree.lua',
        -- requires = {'kyazdani42/nvim-web-devicons'},
        config = require('plugin_configs.nvimtree')
    }

    use {'hrsh7th/nvim-compe', config = require('plugin_configs.compe')}

    -- Themes
    use {
        'Juksuu/VibrantGrey',
        requires = {'tjdevries/colorbuddy.nvim'},
        config = require('plugin_configs.vibrantgrey')
    }

end)
