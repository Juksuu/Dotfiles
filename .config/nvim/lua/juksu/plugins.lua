vim.cmd [[packadd vimball]]

return require('packer').startup {
  function(use)
    use 'wbthomason/packer.nvim'

    -- Languages
    use { 'leafOfTree/vim-svelte-plugin', opt = true, ft = "svelte"}

    -- Nvim lsp
    use 'neovim/nvim-lspconfig'
    use 'nvim-lua/lsp-status.nvim'

    use 'glepnir/lspsaga.nvim'

    -- Completion
    use 'hrsh7th/nvim-compe'

    -- Lua
    use 'tjdevries/nlua.nvim'
    use 'tjdevries/astronauta.nvim'

    use 'ThePrimeagen/harpoon'
    use 'norcalli/nvim-colorizer.lua'

    use 'nvim-lua/plenary.nvim'
    use 'nvim-lua/popup.nvim'

    use { 'nvim-lua/telescope.nvim',
        requires = 'kyazdani42/nvim-web-devicons'
    }

    use 'nvim-telescope/telescope-fzy-native.nvim'
    use 'nvim-telescope/telescope-fzf-writer.nvim'

    use 'nvim-treesitter/nvim-treesitter'

    -- Git
    use 'junegunn/gv.vim'
    use 'mhinz/vim-signify'
    use 'tpope/vim-fugitive'

    -- Fileformat things
    use 'prettier/vim-prettier'
    use 'editorconfig/editorconfig-vim'

    -- Nvim-tree
    use { 'kyazdani42/nvim-tree.lua',
        cmd = { 'NvimTreeToggle', 'NvimTreeOpen' },
        requires = 'kyazdani42/nvim-web-devicons'
    }

    -- Util
    use 'tpope/vim-repeat'
    use 'tpope/vim-surround'
    use 'tpope/vim-commentary'

    use 'Raimondi/delimitMate'
    use 'mhinz/vim-startify'
    use 'mbbill/undotree'
    use 'godlygeek/tabular'
    use 'maxbrunsfeld/vim-yankstack'

    -- Theme / UI
    use 'tjdevries/colorbuddy.nvim'
    use 'tjdevries/cyclist.vim'

    use 'ntk148v/vim-horizon'
    use 'tjdevries/gruvbuddy.nvim'
    use 'gruvbox-community/gruvbox'
  end,
  config = {
    _display = {
      open_fn = function(name)
        -- Can only use plenary when we have our plugins.
        --  We can only get plenary when we don't have our plugins ;)
        local ok, float_win = pcall(function()
          return require('plenary.window.float').percentage_range_window(0.8, 0.8)
        end)

        if not ok then
          vim.cmd [[65vnew  [packer] ]]

          return vim.api.nvim_get_current_win(), vim.api.nvim_get_current_buf()
        end

        local bufnr = float_win.bufnr
        local win = float_win.win_id

        vim.api.nvim_buf_set_name(bufnr, name)
        vim.api.nvim_win_set_option(win, 'winblend', 10)

        return win, bufnr
      end
    },
  }
}
