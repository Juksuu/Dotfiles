-- Reselect visual selection after indenting
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

-- Maintain cursor position when yanking a visual selection
vim.keymap.set("v", "y", "myy`y")
vim.keymap.set("v", "Y", "myY`y")

-- Move visual selection with J and K
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Copy to system clipboard
vim.keymap.set("n", "<leader>Y", '"+yy')
vim.keymap.set("n", "<leader>y", '"+y')
vim.keymap.set("v", "<leader>y", '"+y')

-- Paste from system clipboard
vim.keymap.set("n", "<leader>P", '"+P')
vim.keymap.set("n", "<leader>p", '"+p')
