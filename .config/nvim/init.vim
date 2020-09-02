syntax on
set encoding=utf-8

set nu
set ruler
set hidden
set confirm
set hlsearch
set smarttab
set autoread
set wildmenu
set incsearch
set cursorline
set termguicolors

set complete-=i
set cmdheight=2
set history=1000
set laststatus=2
set shortmess+=c
set tabpagemax=50
set updatetime=300
set nrformats-=octal
set display+=lastline

set title
set titlestring=%t

set expandtab
set autoindent
set shiftwidth=4
set softtabstop=4

set viewoptions-=options
set sessionoptions-=options

set scrolloff=1
set sidescrolloff=5

set ttimeout
set ttimeoutlen=100

set nobackup
set noswapfile
set nowritebackup

set backspace=indent,eol,start

set clipboard=unnamedplus

set undofile
set undodir=~/.config/nvim/undodir

set background=dark

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

" Git
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

" Util
Plug 'tpope/vim-commentary'
Plug 'mbbill/undotree'
Plug 'djoshea/vim-autoread'
Plug 'maxbrunsfeld/vim-yankstack'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'tpope/vim-surround'
Plug 'jiangmiao/auto-pairs'
Plug 'machakann/vim-highlightedyank'
Plug 'editorconfig/editorconfig-vim'
Plug 'prettier/vim-prettier'

" Theme
Plug 'gruvbox-community/gruvbox'
Plug 'sheerun/vim-polyglot'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'kristijanhusak/vim-hybrid-material'

" For fun
Plug 'ThePrimeagen/vim-be-good'

call plug#end()

" Vim
let g:enable_bold_font = 1
let g:enable_italic_font = 1

" Colorscheme
let g:hybrid_transparent_background = 1

let g:gruvbox_contrast_dark = 'hard'
let g:gruvbox_invert_selection='0'

colorscheme hybrid_material

" Airline
let g:airline_theme = 'hybrid'
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail'

" Fzf
let g:fzf_layout = { 'window': { 'width': 0.8, 'height': 0.8 } }
let $FZF_DEFAULT_OPTS='--reverse'

" Editor config
let g:EditorConfig_exclude_patterns = ['fugitive://.*', 'scp://.*']

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

" Auto pairs
let g:AutoPairsShortcutToggle = ''

" Binds

let mapleader = " "
nnoremap <leader>s :source ~/.config/nvim/init.vim<CR>

nnoremap <leader>f :Files<CR>

nnoremap <leader>b :Buffer<CR>

nnoremap <leader>gf :GFiles<CR>
nnoremap <leader>gs :vert :botright :Gstatus<CR>

nmap <Leader>fb <Plug>(Prettier)

nnoremap <silent> <M-j> :bprev<CR>
nnoremap <silent> <M-k> :bnext<CR>

nmap <leader>ce :CocDiagnostics<CR>
nmap <leader>cd <Plug>(coc-definition)
nmap <leader>ct <Plug>(coc-type-definition)
nmap <leader>ci <Plug>(coc-implementation)
nmap <leader>cr <Plug>(coc-references)
nmap <silent> <leader>cp <Plug>(coc-diagnostic-prev-error)
nmap <silent> <leader>cn <Plug>(coc-diagnostic-next-error)
nmap <leader>cf  <Plug>(coc-fix-current)
nnoremap <silent> <leader>cs :<C-u>CocList -I -N symbols<CR>

" Clear highlight after search
nnoremap <silent> <C-L> :nohlsearch<C-R>=has('diff')?'<Bar>diffupdate':''<CR><CR><C-L>

" use <tab> for trigger completion and navigate to the next complete item
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction

inoremap <silent><expr> <Tab>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<Tab>" :
      \ coc#refresh()

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

