let NERDTreeShowHidden = 1

nnoremap <silent> <leader>bc :NERDTreeClose<bar> bd<CR>
nnoremap <Leader>tt :NERDTreeToggle<CR>

" Open nerdtree if no file is specified on startup
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

" Close vim when only nerdtree is open
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
