local map_tele = function(key, f, options, buffer)
  local mode = "n"
  local rhs = string.format(
    "<cmd>lua R('juksu.telescope')['%s'](%s)<CR>",
    f,
    options and vim.inspect(options, { newline = '' }) or ''
  )

  local opts = {
    noremap = true,
    silent = true,
  }

  if not buffer then
    vim.api.nvim_set_keymap(mode, key, rhs, opts)
  else
    vim.api.nvim_buf_set_keymap(0, mode, key, rhs, opts)
  end
end

-- Dotfiles
map_tele('<leader>en', 'edit_neovim')

-- Files
map_tele('<leader>ff', 'fd')
map_tele('<leader>fg', 'git_files')
map_tele('<leader>fs', 'live_grep')

-- Nvim
map_tele('<leader>fb', 'buffers')
map_tele('<leader>fB', 'curbuf')

return map_tele
