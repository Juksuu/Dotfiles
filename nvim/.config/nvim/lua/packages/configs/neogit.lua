return function()
    require("neogit").setup()
    vim.keymap.set("n", "<leader>gs", require("neogit").open)
end
