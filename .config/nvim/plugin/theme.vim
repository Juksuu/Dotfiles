set termguicolors

let g:theme = "forest-night"
let g:airline_theme = "forest_night"

fun! SetTheme()
    execute 'colorscheme ' . g:theme
    set background=dark

    let g:airline_powerline_fonts = 1
    let g:airline#extensions#tabline#enabled = 1
    let g:airline#extensions#tabline#formatter = 'unique_tail'
endfun
call SetTheme()

" Vim with me
nnoremap <leader>st :call SetTheme()<CR>
