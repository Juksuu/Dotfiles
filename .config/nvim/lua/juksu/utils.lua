local M = {}
local cmd = vim.cmd

--[[ 
  Helper to create autocommand groups
  Source: https://icyphox.sh/blog/nvim-lua/
--]]
function M.create_augroup(name, autocmds)
    cmd('augroup ' .. name)
    cmd('autocmd!')
    for _, autocmd in ipairs(autocmds) do
        cmd('autocmd ' .. table.concat(autocmd, ' '))
    end
    cmd('augroup END')
end

return M
