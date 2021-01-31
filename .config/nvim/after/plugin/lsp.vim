set completeopt=menuone,noinsert,noselect

" Lua
lua require("init");

" LspSaga
nnoremap <silent><leader>cf <cmd>lua require'lspsaga.provider'.lsp_finder()<CR>
nnoremap <silent><leader>ca <cmd>lua require'lspsaga.codeaction'.code_action()<CR>
vnoremap <silent><leader>ca <cmd>'<,'>lua require'lspsaga.codeaction'.range_code_action()<CR>
nnoremap <silent><leader>cR <cmd>lua require'lspsaga.rename'.rename()<CR>
nnoremap <silent><leader>cs <cmd>lua require'lspsaga.signaturehelp'.signature_help()<CR>

nnoremap <silent><leader>ld <cmd>lua require'lspsaga.diagnostic'.show_line_diagnostics()<CR>

nnoremap <silent> K <cmd>lua require'lspsaga.hover'.render_hover_doc()<CR>


