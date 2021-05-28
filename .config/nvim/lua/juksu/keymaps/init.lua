local config = require('juksu.keymaps.config')
local bind = vim.api.nvim_set_keymap

-- LuaFormatter off
bind("i", "<TAB>", "v:lua.tab_complete()",
{silent = true, expr = true})

bind("i", "<S-TAB>", "v:lua.s_tab_complete()",
{silent = true, expr = true})

bind("i", "<CR>", "v:lua.enter_complete()",
{silent = true, expr = true})

bind("n", "<leader>ff", "<cmd> lua require('telescope.builtin').find_files() <CR>",
{noremap = true, silent = true})

bind("n", "<leader>n", "<cmd> NvimTreeToggle <CR>",
{noremap = true, silent = true})
-- LuaFormatter on
