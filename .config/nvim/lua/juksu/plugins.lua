vim.cmd [[packadd vimball]]

return require('packer').startup {
  function(use)
    use 'wbthomason/packer.nvim'

    -- Languages
    use 'leafOfTree/vim-svelte-plugin'

    -- Nvim lsp
    use 'glepnir/lspsaga.nvim'
    use 'neovim/nvim-lspconfig'
    use 'nvim-lua/lsp-status.nvim'

    -- Completion
    use 'nvim-lua/completion-nvim'
    use 'steelsojka/completion-buffers'

    -- Lua
    use 'nvim-lua/popup.nvim'
    use 'nvim-lua/plenary.nvim'
    use 'nvim-lua/telescope.nvim'
    use 'norcalli/nvim-colorizer.lua'
    use 'nvim-telescope/telescope-fzy-native.nvim'
    use 'nvim-telescope/telescope-fzf-writer.nvim'
    use 'tjdevries/nlua.nvim'

    -- Git
    use 'junegunn/gv.vim'
    use 'mhinz/vim-signify'
    use 'tpope/vim-fugitive'
    use 'stsewd/fzf-checkout.vim'


    -- Fileformat things
    use 'prettier/vim-prettier'
    use 'editorconfig/editorconfig-vim'

    -- Nerdtree & plugins
    use 'preservim/nerdtree'
    use 'Xuyuanp/nerdtree-git-plugin'
    use 'tiagofumo/vim-nerdtree-syntax-highlight'

    -- Util
    use 'tpope/vim-repeat'
    use 'tpope/vim-surround'
    use 'tpope/vim-commentary'

    use 'hrsh7th/nvim-compe'

    use 'Raimondi/delimitMate'

    use 'mhinz/vim-startify'

    use 'ThePrimeagen/harpoon'

    use 'sheerun/vim-polyglot'

    use 'mbbill/undotree'
    use 'godlygeek/tabular'
    use 'Asheq/close-buffers.vim'
    use 'maxbrunsfeld/vim-yankstack'

    -- Theme / UI
    use 'ryanoasis/vim-devicons'
    use 'tjdevries/cyclist.vim'
    use 'nvim-treesitter/nvim-treesitter'

    use 'ntk148v/vim-horizon'
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
