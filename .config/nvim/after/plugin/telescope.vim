nnoremap <Leader>ff :lua require('telescope.builtin').find_files()<CR>
nnoremap <leader>fg :lua require('telescope.builtin').git_files()<CR>
nnoremap <Leader>fb :lua require('telescope.builtin').buffers()<CR>
nnoremap <Leader>fcd :lua require('telescope.builtin').live_grep()<CR>

nnoremap <Leader>h :lua require('telescope.builtin').command_history()<CR>
