vim.api.nvim_create_user_command("ConfigTrust", function()
    vim.secure.trust({ action = "allow", bufnr = 0 })
    vim.cmd("%so")
end, { nargs = 0 })
