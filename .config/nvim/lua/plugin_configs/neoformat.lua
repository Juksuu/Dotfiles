return function()
    vim.g.neoformat_only_msg_on_error = 1

    -- Format on save
    vim.api.nvim_exec([[
        augroup neoformat
        au!
        au BufWritePre * Neoformat
    augroup end
    ]], false)
end
