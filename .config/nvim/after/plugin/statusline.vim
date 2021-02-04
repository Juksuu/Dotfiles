" Statusline & Tabline/Buffer line
" Dynamically getting the fg/bg colors from the current colorscheme, returns hex which is enough for me to use in Neovim
" Needs to figure out how to return cterm values too

let fgcolor=synIDattr(synIDtrans(hlID("Normal")), "fg", "gui")
let bgcolor=synIDattr(synIDtrans(hlID("Normal")), "bg", "gui")

" Tabline/Buffer line
" set showtabline=2
" set tabline="%T"

let g:currentmode={
      \ 'n'   : 'Normal ',
      \ 'no'  : 'N·Operator Pending ',
      \ 'v'   : 'Visual ',
      \ 'V'   : 'Visual-Line ',
      \ 'x22' : 'Visual-Block ',
      \ 's'   : 'Select ',
      \ 'S'   : 'Select-Line ',
      \ 'x19' : 'Select-Block ',
      \ 'i'   : 'Insert ',
      \ 'R'   : 'Replace ',
      \ 'Rv'  : 'Visual-Replace ',
      \ 'c'   : 'Command ',
      \ 'cv'  : 'Vim Ex ',
      \ 'ce'  : 'Ex ',
      \ 'r'   : 'Prompt ',
      \ 'rm'  : 'More ',
      \ 'r?'  : 'Confirm ',
      \ '!'   : 'Shell ',
      \ 't'   : 'Terminal '
      \}


highlight User1 cterm=None gui=None ctermfg=008 guifg=fgcolor guibg=bgcolor
highlight User2 cterm=None gui=None ctermfg=008 guifg=fgcolor guibg=bgcolor

" Automatically change the statusline color depending on mode
function! ChangeStatuslineColor()
  if (mode() =~# '\v(n|no)')
    exe 'hi! StatusLine ctermfg=008 guifg=fgcolor gui=None cterm=None'
  elseif (mode() =~# '\v(v|V)' || g:currentmode[mode()] ==# 'Visual-Block' || get(g:currentmode, mode(), '') ==# 't')
    exe 'hi! StatusLine ctermfg=005 guifg=#00ff00 gui=None cterm=None'
  elseif (mode() ==# 'i')
    exe 'hi! StatusLine ctermfg=004 guifg=#6CBCE8 gui=None cterm=None'
  else
    exe 'hi! StatusLine ctermfg=006 guifg=orange gui=None cterm=None'
  endif

  return ''
endfunction

function! ReadOnly()
  if &readonly || !&modifiable
    return ''
  else
    return ''
endfunction

function! GitInfo()
  let git = fugitive#head()
  if git != ''
    return ' '.fugitive#head()
  else
    return ''
endfunction

function! LspStatus() abort
  if luaeval('#vim.lsp.buf_get_clients() > 0')
    return luaeval("require('lsp-status').status()")
  endif

  return ''
endfunction

set laststatus=2
set statusline=
set statusline+=%{ChangeStatuslineColor()}               " Changing the statusline color
set statusline+=%0*\ %{g:currentmode[mode()]}   " Current mode
set statusline+=%1*\ [%n]                                " buffernr
set statusline+=%1*\ %{GitInfo()}                        " Git Branch name
set statusline+=%1*\ %<%F\ %{ReadOnly()}\ %m\ %w\        " File+path
set statusline+=%*
set statusline+=%1*\ %=                                  " Space
set statusline+=%1*\ %y\                                 " FileType
set statusline+=%1*\ %{(&fenc!=''?&fenc:&enc)}\[%{&ff}]\ " Encoding & Fileformat
set statusline+=%1*\ %{LspStatus()}\                      " Lsp status
set statusline+=%2*\ %-3l,%3c\ \|\ %-3L
