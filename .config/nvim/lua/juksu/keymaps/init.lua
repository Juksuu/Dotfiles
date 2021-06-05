local config = require('juksu.keymaps.config')
local bind = vim.api.nvim_set_keymap

-- LuaFormatter off

--- INSERT MODE BINDS ---
bind("i", "<TAB>", "v:lua.tab_complete()",
{silent = true, expr = true})
bind("i", "<S-TAB>", "v:lua.s_tab_complete()",
{silent = true, expr = true})
bind("i", "<CR>", "v:lua.enter_complete()",
{silent = true, expr = true})

--- NORMAL MODE BINDS ---
bind("n", "<leader>n", "<cmd> NvimTreeToggle <CR>",
{noremap = true, silent = true})
bind("n", "<leader>gs", ":vert :Git <CR>",
{noremap = true, silent = true})
bind("n", "K", "<cmd> lua vim.lsp.buf.hover() <CR>",
{noremap = true, silent = true})
bind("n", "<leader>cdl", "<cmd> lua vim.lsp.diagnostic.show_line_diagnostics() <CR>",
{noremap = true, silent = true})

-- Harpoon
bind("n", "<leader>th", "<cmd>lua require('harpoon.term').gotoTerminal(1)<CR>",
{noremap = true, silent = true})
bind("n", "<leader>tj", "<cmd>lua require('harpoon.term').gotoTerminal(2)<CR>",
{noremap = true, silent = true})
bind("n", "<leader>tk", "<cmd>lua require('harpoon.term').gotoTerminal(3)<CR>",
{noremap = true, silent = true})

--- TELESCOPE MAPPINGS ---
config.map_tele('<leader>ff', 'find_files')
config.map_tele('<leader>fs', 'live_grep')
config.map_tele('<leader>fS', 'grep_string')
config.map_tele('<leader>fg', 'git_files')

config.map_tele('<leader>gw', 'git_worktrees')
config.map_tele('<leader>gn', 'create_git_worktree')
config.map_tele('<leader>gS', 'git_stash')

config.map_tele('gd', 'lsp_definitions')
config.map_tele('<leader>cr', 'lsp_references')
config.map_tele('<leader>ca', 'lsp_code_actions')
config.map_tele('<leader>cd', 'lsp_document_diagnostics')
config.map_tele('<leader>cD', 'lsp_workspace_diagnostics')

-- LuaFormatter on
