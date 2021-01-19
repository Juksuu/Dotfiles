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
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/completion-nvim'

" Git
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

" Telescope
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-lua/telescope.nvim'

" Fzf
Plug 'junegunn/fzf.vim'
Plug 'stsewd/fzf-checkout.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }

" Fileformat things
Plug 'prettier/vim-prettier'
Plug 'editorconfig/editorconfig-vim'

" Util
Plug 'mbbill/undotree'
Plug 'godlygeek/tabular'
Plug 'tpope/vim-surround'
Plug 'preservim/nerdtree'
Plug 'Yggdroot/indentLine'
Plug 'tpope/vim-commentary'
Plug 'djoshea/vim-autoread'
Plug 'Raimondi/delimitMate'
Plug 'tjdevries/vim-inyoface'
Plug 'Asheq/close-buffers.vim'
Plug 'maxbrunsfeld/vim-yankstack'
Plug 'norcalli/nvim-colorizer.lua'
Plug 'machakann/vim-highlightedyank'

" Theme
Plug 'sheerun/vim-polyglot'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

Plug 'arcticicestudio/nord-vim'
Plug 'chriskempson/tomorrow-theme', { 'rtp': 'vim' }
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
    autocmd BufWritePre * :call TrimWhitespace()
augroup END

augroup CorrectFiletypes
    autocmd!
    autocmd BufNewFile,BufRead *.tsx   set filetype=typescript.tsx
augroup END

