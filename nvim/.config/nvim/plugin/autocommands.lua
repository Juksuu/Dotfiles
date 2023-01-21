vim.api.nvim_create_autocmd("TextYankPost", {
    callback = function()
        vim.highlight.on_yank({ higroup = "IncSearch", timeout = 400 })
    end,
})

vim.api.nvim_create_autocmd("FileType", {
    callback = function()
        vim.opt_local.formatoptions = vim.opt_local.formatoptions - "o"
    end,
})
