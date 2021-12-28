vim.g.mapleader = " "

function KEYMAP(mode, lhs, rhs, opts)
    local options = { noremap = true }
    if opts then
        options = vim.tbl_extend("force", options, opts)
    end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

-- Reselect visual selection after indenting
KEYMAP("v", "<", "<gv")
KEYMAP("v", ">", ">gv")

-- Maintain cursor position when yanking a visual selection
KEYMAP("v", "y", "myy`y")
KEYMAP("v", "Y", "myY`y")

-- Move visual selection with J and K
KEYMAP("v", "J", ":m '>+1<CR>gv=gv")
KEYMAP("v", "K", ":m '<-2<CR>gv=gv")

--- NORMAL MODE BINDS ---
KEYMAP("n", "<leader>nt", "<cmd> NvimTreeToggle <CR>")
KEYMAP("n", "<leader>gs", "<cmd> lua require('neogit').open() <CR>")

-- LSP
KEYMAP("n", "K", "<cmd> lua vim.lsp.buf.hover() <CR>")
KEYMAP(
    "n",
    "<leader>lld",
    "<cmd> lua vim.diagnostic.open_float({ border = 'single' }) <CR>"
)
KEYMAP("n", "<leader>lR", "<cmd> lua vim.lsp.buf.rename() <CR>")

-- Harpoon
KEYMAP(
    "n",
    "<leader>th",
    "<cmd> lua require('harpoon.term').gotoTerminal(1)<CR>"
)
KEYMAP(
    "n",
    "<leader>tj",
    "<cmd> lua require('harpoon.term').gotoTerminal(2)<CR>"
)
KEYMAP(
    "n",
    "<leader>tk",
    "<cmd> lua require('harpoon.term').gotoTerminal(3)<CR>"
)

KEYMAP("n", "<C-j>", "<cmd> lua require('harpoon.ui').nav_file(1)<CR>")
KEYMAP("n", "<C-k>", "<cmd> lua require('harpoon.ui').nav_file(2)<CR>")
KEYMAP("n", "<leader>ma", "<cmd> lua require('harpoon.mark').add_file()<CR>")
KEYMAP(
    "n",
    "<leader>mm",
    "<cmd> lua require('harpoon.ui').toggle_quick_menu()<CR>"
)

-- LuaSnip (TODO: Make this prettier somehow)
KEYMAP("n", "<C-h>", "<cmd> lua require('luasnip').jump(-1)<CR>")
KEYMAP("n", "<C-l>", "<cmd> lua require('luasnip').jump(1)<CR>")
KEYMAP("s", "<C-h>", "<cmd> lua require('luasnip').jump(-1)<CR>")
KEYMAP("s", "<C-l>", "<cmd> lua require('luasnip').jump(1)<CR>")
KEYMAP(
    "i",
    "<C-h>",
    "<cmd> lua require('luasnip').jump(-1)<CR>",
    { noremap = false }
)
KEYMAP(
    "i",
    "<C-l>",
    "<cmd> lua require('luasnip').jump(1)<CR>",
    { noremap = false }
)

-- Neogen
KEYMAP("n", "<leader>ng", "<cmd> lua require('neogen').generate()<CR>")

--- TELESCOPE MAPPINGS ---
local function map_tele(key, f)
    KEYMAP(
        "n",
        key,
        string.format(
            "<cmd> lua require('plugin_configs.telescope.functions')['%s'](%s)<CR>",
            f,
            ""
        )
    )
end
map_tele("<leader>sf", "find_files")
map_tele("<leader>ss", "live_grep")
map_tele("<leader>sg", "git_files")

map_tele("gd", "lsp_definitions")

map_tele("<leader>lr", "lsp_references")
map_tele("<leader>la", "lsp_code_actions")
map_tele("<leader>ld", "diagnostics")
map_tele("<leader>lD", "workspace_diagnostics")

map_tele("<leader>gw", "worktrees")
map_tele("<leader>gn", "create_worktree")
