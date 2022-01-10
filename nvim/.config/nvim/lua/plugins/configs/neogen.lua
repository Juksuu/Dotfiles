return function()
    require("neogen").setup({
        enabled = true,
    })

    vim.keymap.set("n", "<leader>ng", require("neogen").generate)
end
