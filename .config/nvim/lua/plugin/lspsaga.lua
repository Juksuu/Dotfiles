local nnoremap = vim.keymap.nnoremap

nnoremap { '<leader>cf', function() require('lspsaga.provider').lsp_finder() end}
nnoremap { '<leader>ca', function() require('lspsaga.codeaction').code_action() end}
nnoremap { '<leader>cr', function() require('lspsaga.rename').rename() end}
nnoremap { '<leader>cs', function() require('lspsaga.signaturehelp').signature_help() end}

nnoremap { '<leader>dl', function() require('lspsaga.diagnostic').show_line_diagnostics() end}
nnoremap { '<leader>dn', function() require('lspsaga.diagnostic').lsp_jump_diagnostic_next() end}
nnoremap { '<leader>dp', function() require('lspsaga.diagnostic').lsp_jump_diagnostic_prev() end}

nnoremap { 'K', function() require('lspsaga.hover').render_hover_doc() end}
