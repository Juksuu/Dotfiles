set termguicolors

let g:theme = "forest-night"

fun! SetTheme()
    execute 'colorscheme ' . g:theme
    set background=dark
endfun
call SetTheme()

" Vim with me
nnoremap <leader>st :call SetTheme()<CR>
