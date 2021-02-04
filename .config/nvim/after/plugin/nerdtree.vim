let NERDTreeShowHidden = 1

nnoremap <silent> <leader>bc :NERDTreeClose<bar> bd<CR>
nnoremap <Leader>n :NERDTreeToggle<CR>

" Close vim when only nerdtree is open
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
