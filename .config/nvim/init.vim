syntax on
set encoding=utf-8
filetype plugin indent on

set ruler
set hidden
set nu rnu
set confirm
set hlsearch
set smarttab
set autoread
set wildmenu
set incsearch
set termguicolors
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
set ttimeoutlen=50

set nobackup
set noswapfile
set nowritebackup

set backspace=indent,eol,start
set completeopt=menuone,noinsert,noselect
set clipboard=unnamedplus

set undofile
set undodir=~/.config/nvim/undodir

set pyxversion=3

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

" Util
Plug 'mbbill/undotree'
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-surround'
Plug 'preservim/nerdtree'
Plug 'Yggdroot/indentLine'
Plug 'tpope/vim-commentary'
Plug 'djoshea/vim-autoread'
Plug 'Raimondi/delimitMate'
Plug 'prettier/vim-prettier'
Plug 'stsewd/fzf-checkout.vim'
Plug 'Asheq/close-buffers.vim'
Plug 'maxbrunsfeld/vim-yankstack'
Plug 'editorconfig/editorconfig-vim'
Plug 'machakann/vim-highlightedyank'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }

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

" Colorscheme
set background=dark
colorscheme Tomorrow-Night

hi Normal guibg=NONE ctermbg=NONE

" Airline
let g:airline_theme = 'tomorrow'
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail'

" Fzf
let g:fzf_layout = { 'window': { 'width': 0.8, 'height': 0.8 } }
let $FZF_DEFAULT_OPTS='--reverse'
let g:fzf_branch_actions = {
      \ 'rebase': {
      \   'prompt': 'Rebase> ',
      \   'execute': 'echo system("{git} rebase {branch}")',
      \   'multiple': v:false,
      \   'keymap': 'ctrl-r',
      \   'required': ['branch'],
      \   'confirm': v:false,
      \ },
      \ 'track': {
      \   'prompt': 'Track> ',
      \   'execute': 'echo system("{git} checkout --track {branch}")',
      \   'multiple': v:false,
      \   'keymap': 'ctrl-t',
      \   'required': ['branch'],
      \   'confirm': v:false,
      \ },
      \}

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

" NERDTree
let NERDTreeShowHidden = 1

" Lua config setup
lua require('init')
lua require('telescope').setup({ defaults = { file_sorter = require('telescope.sorters').get_fzy_sorter }})

" Binds
let mapleader = " "
nnoremap <leader>s :source ~/.config/nvim/init.vim<CR>

nnoremap <silent> <M-j> :bprev<CR>
nnoremap <silent> <M-k> :bnext<CR>

nnoremap <leader>bo :Bdelete other<CR>
nnoremap <silent> <leader>bc :NERDTreeClose<bar> bd<CR>

nnoremap <leader>gc :GBranches<CR>
nnoremap <leader>gs :vert :botright :Gstatus<CR>

" File formatting
nmap <Leader>fcb <Plug>(Prettier)

" Clear highlight after search
nnoremap <silent> <C-L> :nohlsearch<C-R>=has('diff')?'<Bar>diffupdate':''<CR><CR><C-L>

" Command history
nnoremap <Leader>h :lua require('telescope.builtin').command_history()<CR>

" Toggles
nmap <Leader>tt :NERDTreeToggle<CR>
nmap <Leader>ti :IndentLinesToggle<CR>

" Search
nnoremap <Leader>ff :lua require('telescope.builtin').find_files()<CR>
nnoremap <leader>fg :lua require('telescope.builtin').git_files()<CR>
nnoremap <Leader>fb :lua require('telescope.builtin').buffers()<CR>
nnoremap <Leader>fcd :lua require('telescope.builtin').live_grep()<CR>

" Lsp
nnoremap <leader>cd :lua vim.lsp.buf.definition()<CR>
nnoremap <leader>ci :lua vim.lsp.buf.implementation()<CR>
nnoremap <leader>cr :lua vim.lsp.buf.references()<CR>
nnoremap <leader>cR :lua vim.lsp.buf.rename()<CR>
nnoremap <leader>cf :lua vim.lsp.buf.code_action()<CR>
nnoremap <leader>cl :lua vim.lsp.diagnostic.show_line_diagnostics()<CR>
nnoremap <silent>K :lua vim.lsp.buf.hover()<CR>


" Open nerdtree if no file is specified on startup
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

" Close vim when only nerdtree is open
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
