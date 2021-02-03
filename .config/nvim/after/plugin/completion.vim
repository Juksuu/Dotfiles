let g:completion_trigger_on_delete = 1
let g:completion_enable_auto_popup = 1


let g:completion_chain_complete_list = [
    \{'complete_items': ['lsp', 'buffers']},
    \{'mode': '<c-p>'},
    \{'mode': '<c-n>'}
\]

imap <tab> <Plug>(completion_smart_tab)
imap <s-tab> <Plug>(completion_smart_s_tab)

inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
