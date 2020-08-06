syntax on

" Indentation
set expandtab
set autoindent
set shiftwidth=4
set softtabstop=4

" Title
set title
set titlestring=%t

" Misc
set ruler
set hidden
set confirm
set autoread
set incsearch
set cursorline
set cmdheight=2
set shortmess+=c
set updatetime=300
set relativenumber

set nobackup
set noswapfile
set nowritebackup

set clipboard=unnamedplus

set undofile
set undodir=~/.config/nvim/undodir

set background=dark


"setup vim-plug {{{
  "Note: install vim-plug if not present
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

" Git
Plug 'tpope/vim-fugitive'

" Util
Plug 'tpope/vim-commentary'
Plug 'mbbill/undotree'
Plug 'djoshea/vim-autoread'
Plug 'maxbrunsfeld/vim-yankstack'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'tpope/vim-surround'

" Theme
Plug 'gruvbox-community/gruvbox'
Plug 'joshdick/onedark.vim'
Plug 'vim-airline/vim-airline'
Plug 'sheerun/vim-polyglot'

" For fun
Plug 'ThePrimeagen/vim-be-good'

call plug#end()

" Colorscheme
colorscheme onedark

let g:gruvbox_contrast_dark = 'hard'
let g:gruvbox_invert_selection='0'

" Airline
let g:airline#extensions#tabline#enabled = 1
let g:airline_theme='onedark'

" Fzf
let g:fzf_layout = { 'window': { 'width': 0.8, 'height': 0.8 } }
let $FZF_DEFAULT_OPTS='--reverse'

" Polyglot
let g:go_highlight_build_constraints = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_operators = 1
let g:go_highlight_structs = 1
let g:go_highlight_types = 1
let g:go_highlight_function_parameters = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_generate_tags = 1
let g:go_highlight_format_strings = 1
let g:go_highlight_variable_declarations = 1
let g:go_auto_sameids = 1

" Binds
let mapleader = " "
nnoremap <leader>s :source ~/.config/nvim/init.vim<CR>

nnoremap <leader>f :Files<CR>

nnoremap <leader>b :Buffer<CR>

nnoremap <leader>gf :GFiles<CR>
nnoremap <leader>gs :Gstatus<CR>

nmap <leader>ce :CocDiagnostics<CR>
nmap <leader>cd <Plug>(coc-definition)
nmap <leader>ct <Plug>(coc-type-definition)
nmap <leader>ci <Plug>(coc-implementation)
nmap <leader>cr <Plug>(coc-references)
nmap <silent> <leader>cp <Plug>(coc-diagnostic-prev-error)
nmap <silent> <leader>cn <Plug>(coc-diagnostic-next-error)

" use <tab> for trigger completion and navigate to the next complete item
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction

inoremap <silent><expr> <Tab>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<Tab>" :
      \ coc#refresh()

