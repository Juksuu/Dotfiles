local M = {
    "ThePrimeagen/harpoon",
    event = "BufReadPost",
}

M.config = function()
    require("harpoon").setup({
        menu = {
            width = vim.api.nvim_win_get_width(0) - 4,
        },
    })

    vim.keymap.set("n", "<leader>ma", require("harpoon.mark").add_file)
    vim.keymap.set("n", "<leader>ms", require("harpoon.ui").toggle_quick_menu)

    vim.keymap.set("n", "<m-a>", function() require("harpoon.ui").nav_file(1) end)
    vim.keymap.set("n", "<m-s>", function() require("harpoon.ui").nav_file(2) end)
    vim.keymap.set("n", "<m-d>", function() require("harpoon.ui").nav_file(3) end)
    vim.keymap.set("n", "<m-f>", function() require("harpoon.ui").nav_file(4) end)
end

return M
