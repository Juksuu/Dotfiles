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
    elseif check_back_space() then
        return t "<Tab>"
    else
        return vim.fn['compe#complete']()
    end
end

_G.s_tab_complete = function()
    if vim.fn.pumvisible() == 1 then
        return t "<C-p>"
    else
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

local M = {}

-- Telescope bindings
function M.map_tele(key, f, options, buffer)
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

return M
