local M = {}

M.print = function(v)
    print(vim.inspect(v))
    return v
end

M.reload_module = function(name)
    require("plenary.reload").reload_module(name)
    return require(name)
end

return M
