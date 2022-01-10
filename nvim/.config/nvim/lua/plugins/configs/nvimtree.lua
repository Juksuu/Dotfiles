return function()
    require("nvim-tree").setup({
        update_cwd = true,
        git = {
            ignore = false,
        },
    })

    vim.keymap.set("n", "<leader>nt", "<cmd> NvimTreeToggle <CR>")
end
