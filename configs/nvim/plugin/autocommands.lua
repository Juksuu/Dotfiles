vim.api.nvim_create_autocmd("TextYankPost", {
    callback = function()
        vim.highlight.on_yank({ higroup = "IncSearch", timeout = 400 })
    end,
})

vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = "*",
    callback = function(args)
        local ok, conform = pcall(require, "conform")
        if ok then
            conform.format({
                async = true,
                bufnr = args.buf,
                lsp_fallback = true,
            })
        end
    end,
})
