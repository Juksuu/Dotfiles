vim.g.nvim_tree_follow = 1
vim.g.nvim_tree_hide_dotfiles = 1
vim.g.nvim_tree_indent_markers = 1

  -- vim.g.nvim_tree_icons = {
  --   default =  '',
  --   symlink =  '',
  --   git = {
  --    unstaged = "✚",
  --    staged =  "✚",
  --    unmerged =  "≠",
  --    renamed =  "≫",
  --    untracked = "★",
  --   },
  -- }

vim.api.nvim_set_keymap('n', '<leader>n', ':NvimTreeToggle <CR>', {})
