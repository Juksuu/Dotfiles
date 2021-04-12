set list

if !get(g:, 'loaded_cyclist', v:false)
  finish
endif

call cyclist#add_listchar_option_set('limited', {
        \ 'eol': '?',
        \ 'tab': 'Θ ',
        \ 'trail': 'α',
        \ 'extends': '<',
        \ 'precedes': '>',    
        \ 'conceal': '?',
        \ 'nbsp': '?',
        \ })

call cyclist#add_listchar_option_set('busy', {
        \ 'eol': '?',
        \ 'tab': 'Θα',
        \ 'space': '?',
        \ 'trail': '-',
        \ 'extends': '?',
        \ 'precedes': '?',    
        \ 'conceal': '?',
        \ 'nbsp': '?',
        \ })

" nmap <leader>cl <Plug>CyclistNext
