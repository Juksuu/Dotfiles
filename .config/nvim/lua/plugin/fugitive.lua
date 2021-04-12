-- local nnoremap = vim.keymap.nnoremap

-- nnoremap { '<leader>gs', vim.cmd [[ :vert :botright :Git ]]}
vim.api.nvim_set_keymap("n", "<leader>gs", ":vert :botright :Git <CR>", {})
