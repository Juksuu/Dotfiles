vim.g.mapleader = " "
local mapx = require("mapx").setup({ whichkey = true })

-- Reselect visual selection after indenting
mapx.vnoremap("<", "<gv")
mapx.vnoremap(">", ">gv")

-- Maintain cursor position when yanking a visual selection
mapx.vnoremap("y", "myy`y")
mapx.vnoremap("Y", "myY`y")

-- Move visual selection with J and K
mapx.vnoremap("J", ":m '>+1<CR>gv=gv")
mapx.vnoremap("K", ":m '<-2<CR>gv=gv")

mapx.nname("<leader>l", "Lsp")
mapx.nname("<leader>g", "Git")
mapx.nname("<leader>s", "Search")
mapx.nname("<leader>t", "Terminal")
mapx.nname("<leader>m", "Harpoon nav")

--- NORMAL MODE BINDS ---
mapx.nnoremap("<leader>n", "<cmd> NvimTreeToggle <CR>", "NvimTree")
mapx.nnoremap("<leader>gs", "<cmd> lua require('neogit').open() <CR>", "Neogit")

-- LSP
mapx.nnoremap("K", "<cmd> lua vim.lsp.buf.hover() <CR>")
mapx.nnoremap(
    "<leader>lld",
    "<cmd> lua vim.lsp.diagnostic.show_line_diagnostics() <CR>",
    "Line diagnostics"
)
mapx.nnoremap("<leader>lR", "<cmd> lua vim.lsp.buf.rename() <CR>", "Rename")

-- Harpoon
mapx.nnoremap(
    "<leader>th",
    "<cmd> lua require('harpoon.term').gotoTerminal(1)<CR>",
    "Terminal 1"
)
mapx.nnoremap(
    "<leader>tj",
    "<cmd> lua require('harpoon.term').gotoTerminal(2)<CR>",
    "Terminal 2"
)
mapx.nnoremap(
    "<leader>tk",
    "<cmd> lua require('harpoon.term').gotoTerminal(3)<CR>",
    "Terminal 3"
)

mapx.nnoremap("<C-j>", "<cmd> lua require('harpoon.ui').nav_file(1)<CR>")
mapx.nnoremap("<C-k>", "<cmd> lua require('harpoon.ui').nav_file(2)<CR>")
mapx.nnoremap("<C-u>", "<cmd> lua require('harpoon.ui').nav_file(3)<CR>")
mapx.nnoremap("<C-i>", "<cmd> lua require('harpoon.ui').nav_file(4)<CR>")
mapx.nnoremap(
    "<leader>ma",
    "<cmd> lua require('harpoon.mark').add_file()<CR>",
    "Add file"
)
mapx.nnoremap(
    "<leader>mm",
    "<cmd> lua require('harpoon.ui').toggle_quick_menu()<CR>",
    "Menu"
)

mapx.imap(
    "<C-l>",
    "luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : '<c-l>'",
    "Snippets jump or expand"
)
mapx.inoremap(
    "<C-h>",
    "<cmd> lua require('luasnip').jump(-1)<CR>",
    "Snippets jump backwards"
)
mapx.snoremap(
    "<C-h>",
    "<cmd> lua require('luasnip').jump(-1)<CR>",
    "Snippets jump backwards"
)
mapx.snoremap(
    "<C-l>",
    "<cmd> lua require('luasnip').jump(1)<CR>",
    "Snippets jump forwards"
)

--- TELESCOPE MAPPINGS ---
local function map_tele(key, f, whichkey)
    mapx.nnoremap(
        key,
        string.format(
            "<cmd> lua require('plugin_configs.telescope.functions')['%s'](%s)<CR>",
            f,
            ""
        ),
        whichkey
    )
end
map_tele("<leader>sf", "find_files", "Find Files")
map_tele("<leader>ss", "live_grep", "Telescope live grep")
map_tele("<leader>sg", "git_files", "Git files")

map_tele("gd", "lsp_definitions")

map_tele("<leader>lr", "lsp_references", "References")
map_tele("<leader>la", "lsp_code_actions", "Code actions")
map_tele("<leader>ld", "lsp_document_diagnostics", "Document diagnostics")
map_tele("<leader>lD", "lsp_workspace_diagnostics", "Workspace diagnostics")

map_tele("<leader>gw", "worktrees", "Git worktrees")
map_tele("<leader>gn", "create_worktree", "Create new worktree")
