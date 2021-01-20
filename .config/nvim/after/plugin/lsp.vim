set completeopt=menuone,noinsert,noselect

nnoremap <leader>cd :lua vim.lsp.buf.definition()<CR>
nnoremap <leader>ci :lua vim.lsp.buf.implementation()<CR>
nnoremap <leader>cr :lua vim.lsp.buf.references()<CR>
nnoremap <leader>cR :lua vim.lsp.buf.rename()<CR>
nnoremap <leader>cf :lua vim.lsp.buf.code_action()<CR>
nnoremap <leader>cl :lua vim.lsp.diagnostic.show_line_diagnostics()<CR>
nnoremap <silent>K :lua vim.lsp.buf.hover()<CR>
