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

-- Files
map_tele('<space>ff', 'fd')
map_tele('<space>fg', 'git_files')
map_tele('<space>fs', 'live_grep')

-- Nvim
map_tele('<space>fb', 'buffers')
map_tele('<space>fB', 'curbuf')

return map_tele
