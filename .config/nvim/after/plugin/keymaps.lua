local function check_back_space()
    local col = vim.fn.col('.') - 1
    if col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
        return true
    else
        return false
    end
end

local t = function(str)
    return vim.api.nvim_replace_termcodes(str, true, true, true)
end
_G.tab_complete = function()
    if vim.fn.pumvisible() == 1 then
        return t "<C-n>"
    elseif vim.fn.call("vsnip#available", {1}) == 1 then
        return t "<Plug>(vsnip-jump-next)"
    elseif check_back_space() then
        return t "<Tab>"
    else
        return vim.fn['compe#complete']()
    end
end

_G.s_tab_complete = function()
    if vim.fn.pumvisible() == 1 then
        return t "<C-p>"
    elseif vim.fn.call("vsnip#jumpable", {-1}) == 1 then
        return t "<Plug>(vsnip-jump-prev)"
    else
        -- If <S-Tab> is not working in your terminal, change it to <C-h>
        return t "<S-Tab>"
    end
end

_G.enter_complete = function()
    if vim.fn.pumvisible() == 1 then
        return vim.fn['compe#confirm']()
    else
        return t "<CR>"
    end
end

-- Telescope bindings
local function map_tele(key, f, options, buffer)
    local mode = "n"
    local rhs = string.format(
                    "<cmd> lua R('plugin_configs.telescope.functions')['%s'](%s)<CR>",
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
bind("n", "<leader>gs", "<cmd> vert Git <CR>",
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
bind("n", "<leader>th", "<cmd>lua require('harpoon.term').gotoTerminal(1)<CR>",
{noremap = true, silent = true})
bind("n", "<leader>tj", "<cmd>lua require('harpoon.term').gotoTerminal(2)<CR>",
{noremap = true, silent = true})
bind("n", "<leader>tk", "<cmd>lua require('harpoon.term').gotoTerminal(3)<CR>",
{noremap = true, silent = true})

--- TELESCOPE MAPPINGS ---
map_tele('<leader>ff', 'find_files')
map_tele('<leader>fs', 'live_grep')
map_tele('<leader>fS', 'grep_string')
map_tele('<leader>fg', 'git_files')
map_tele('<leader>fm', 'media_files')

map_tele('<leader>zl', 'z_list_dirs')

map_tele('<leader>gw', 'git_worktrees')
map_tele('<leader>gn', 'create_git_worktree')
map_tele('<leader>gS', 'git_stash')

map_tele('gd', 'lsp_definitions')
map_tele('<leader>cr', 'lsp_references')
map_tele('<leader>ca', 'lsp_code_actions')
map_tele('<leader>cd', 'lsp_document_diagnostics')
map_tele('<leader>cD', 'lsp_workspace_diagnostics')

-- LuaFormatter on
