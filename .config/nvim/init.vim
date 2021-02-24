"setup vim-plug {{{ Note: install vim-plug if not present

  if empty(glob('~/.config/nvim/autoload/plug.vim'))
    silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall
  endif

  "Note: Skip initialization for vim-tiny or vim-small.
  if !1 | finish | endif
  if has('vim_starting')
    set nocompatible               " Be iMproved
    " Required:
    call plug#begin()
  endif
"}}}

call plug#begin('~/.config/nvim/plugged')

" Nvim lsp
Plug 'glepnir/lspsaga.nvim'
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/lsp-status.nvim'

" Completion
Plug 'nvim-lua/completion-nvim'
Plug 'steelsojka/completion-buffers'

" Lua
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-lua/telescope.nvim'
Plug 'norcalli/nvim-colorizer.lua'
Plug 'nvim-telescope/telescope-fzy-native.nvim'
Plug 'nvim-telescope/telescope-fzf-writer.nvim'

" Git
Plug 'junegunn/gv.vim'
Plug 'mhinz/vim-signify'
Plug 'tpope/vim-fugitive'
Plug 'stsewd/fzf-checkout.vim'

" Fzf
Plug 'junegunn/fzf.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }

" Fileformat things
Plug 'prettier/vim-prettier'
Plug 'editorconfig/editorconfig-vim'

" Nerdtree & plugins
Plug 'preservim/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'

" Util
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'

Plug 'mhinz/vim-startify'

Plug 'ThePrimeagen/harpoon'

Plug 'sheerun/vim-polyglot'

Plug 'mbbill/undotree'
Plug 'godlygeek/tabular'
Plug 'Asheq/close-buffers.vim'
Plug 'maxbrunsfeld/vim-yankstack'

" Theme / UI
Plug 'hrsh7th/nvim-compe'
Plug 'ryanoasis/vim-devicons'
Plug 'nvim-treesitter/nvim-treesitter'

Plug 'glepnir/zephyr-nvim'
Plug 'ntk148v/vim-horizon'
Plug 'sainnhe/forest-night'
Plug 'arcticicestudio/nord-vim'
Plug 'bluz71/vim-moonfly-colors'
Plug 'gruvbox-community/gruvbox'
Plug 'sonph/onehalf', { 'rtp': 'vim' }

" For fun
Plug 'ThePrimeagen/vim-be-good'

call plug#end()

" Vim
let g:enable_bold_font = 1
let g:enable_italic_font = 1

" Binds
let mapleader = " "
nnoremap <leader>s :source ~/.config/nvim/init.vim<CR>

nnoremap <silent> <M-j> :bprev<CR>
nnoremap <silent> <M-k> :bnext<CR>
nnoremap <leader>bo :Bdelete other<CR>

fun! TrimWhitespace()
    let l:save = winsaveview()
    keeppatterns %s/\s\+$//e
    call winrestview(l:save)
endfun

augroup JUKSU
    autocmd!
    " Use completion-nvim in every buffer
    autocmd BufEnter * lua require'completion'.on_attach()

    autocmd BufWritePre * :call TrimWhitespace()
    autocmd TextYankPost *  silent! lua require'vim.highlight'.on_yank()
augroup END
