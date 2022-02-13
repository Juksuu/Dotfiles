local M = {}

M.create_autocommands = function(definitions)
    for group_name, definition in pairs(definitions) do
        vim.api.nvim_command("augroup " .. group_name)
        vim.api.nvim_command("autocmd!")
        for _, def in ipairs(definition) do
            local command = table.concat(vim.tbl_flatten({ "autocmd", def }), " ")
            vim.api.nvim_command(command)
        end
        vim.api.nvim_command("augroup END")
    end
end

M.print = function(v)
    print(vim.inspect(v))
    return v
end

M.reload_module = function(name)
    require("plenary.reload").reload_module(name)
    return require(name)
end

return M
