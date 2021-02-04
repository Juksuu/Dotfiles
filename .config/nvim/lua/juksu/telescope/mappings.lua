-- nnoremap <Leader>ff :lua require('telescope.builtin').find_files()<CR>
-- nnoremap <leader>fg :lua require('telescope.builtin').git_files()<CR>
-- nnoremap <Leader>fb :lua require('telescope.builtin').buffers()<CR>
-- nnoremap <Leader>fs :lua require('telescope.builtin').live_grep()<CR>

-- nnoremap <Leader>h :lua require('telescope.builtin').command_history()<CR>
--

local map_tele = function(key, f, options, buffer)
  local mode = "n"
  local rhs = string.format(
    "<cmd>lua R('juksu.telescope')['%s'](%s)<CR>",
    f,
    options and vim.inspect(options, { newline = '' }) or ''
  )
  local options = {
    noremap = true,
    silent = true,
  }

  if not buffer then
    vim.api.nvim_set_keymap(mode, key, rhs, options)
  else
    vim.api.nvim_buf_set_keymap(0, mode, key, rhs, options)
  end
end

-- Dotfiles
map_tele('<leader>en', 'edit_neovim')

-- Search
-- map_tele('<space>fs', 'grep_string', {
--   short_path = true,
--   word_match = '-w',
--   only_sort_text = true
-- })

-- Files
map_tele('<space>ff', 'fd')
map_tele('<space>fg', 'git_files')
map_tele('<space>fs', 'live_grep')

-- Nvim
map_tele('<space>fb', 'buffers')
map_tele('<space>fa', 'search_all_files')
map_tele('<space>fcb', 'curbuf')
map_tele('<space>gp', 'grep_prompt')

return map_tele
