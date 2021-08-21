-- Telescope bindings
local function map_tele(key, f, options, buffer)
    local mode = "n"
    local rhs = string.format(
                    "<cmd> lua require('plugin_configs.telescope.functions')['%s'](%s)<CR>",
                    f, options and vim.inspect(options, {newline = ''}) or '')

    local opts = {noremap = true, silent = true}

    if not buffer then
        vim.api.nvim_set_keymap(mode, key, rhs, opts)
    else
        vim.api.nvim_buf_set_keymap(0, mode, key, rhs, opts)
    end
end

vim.g.mapleader = ' '
local bind = vim.api.nvim_set_keymap

-- LuaFormatter off

--- NORMAL MODE BINDS ---
bind("n", "<leader>n", "<cmd> NvimTreeToggle <CR>",
{noremap = true, silent = true})
bind("n", "<leader>gs", "<cmd> lua require('neogit').open() <CR>",
{noremap = true, silent = true})
bind("n", "<leader>so", "<cmd> so $HOME/.config/nvim/init.lua <CR>",
{noremap = true, silent = true})
bind("n", "<leader>s", "<cmd> ISwap <CR>",
{noremap = true, silent = true})

-- LSP
bind("n", "K", "<cmd> lua vim.lsp.buf.hover() <CR>",
{noremap = true, silent = true})
bind("n", "<leader>cdl", "<cmd> lua vim.lsp.diagnostic.show_line_diagnostics() <CR>",
{noremap = true, silent = true})
bind("n", "<leader>cR", "<cmd> lua vim.lsp.buf.rename() <CR>",
{noremap = true, silent = true})

-- Harpoon
bind("n", "<leader>th", "<cmd> lua require('harpoon.term').gotoTerminal(1)<CR>",
{noremap = true, silent = true})
bind("n", "<leader>tj", "<cmd> lua require('harpoon.term').gotoTerminal(2)<CR>",
{noremap = true, silent = true})
bind("n", "<leader>tk", "<cmd> lua require('harpoon.term').gotoTerminal(3)<CR>",
{noremap = true, silent = true})

--- TELESCOPE MAPPINGS ---
map_tele('<leader>ff', 'find_files')
map_tele('<leader>fs', 'live_grep')
map_tele('<leader>fS', 'grep_string')
map_tele('<leader>fg', 'git_files')

map_tele('gd', 'lsp_definitions')
map_tele('<leader>cr', 'lsp_references')
map_tele('<leader>ca', 'lsp_code_actions')
map_tele('<leader>cd', 'lsp_document_diagnostics')
map_tele('<leader>cD', 'lsp_workspace_diagnostics')

-- LuaFormatter on
