return function()
    -- Format on save
    vim.api.nvim_exec([[
        augroup neoformat
        au!
        au BufWritePre * Neoformat
    augroup end
    ]], false)
end
