local M = {}

M.create_autocommands = function(definitions)
    for group_name, definition in pairs(definitions) do
        vim.api.nvim_command("augroup " .. group_name)
        vim.api.nvim_command("autocmd!")
        for _, def in ipairs(definition) do
            local command = table.concat(
                vim.tbl_flatten({ "autocmd", def }),
                " "
            )
            vim.api.nvim_command(command)
        end
        vim.api.nvim_command("augroup END")
    end
end

M.map = function(mode, lhs, rhs, opts)
    local options = { noremap = true }
    if opts then
        options = vim.tbl_extend("force", options, opts)
    end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

return M
