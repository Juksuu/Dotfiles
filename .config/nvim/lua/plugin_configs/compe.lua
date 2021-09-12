-- LuaFormatter off
return function()
    require('compe').setup({
        enabled = true,
        source = {
            path = true,
            buffer = true,
            nvim_lsp = true,
            nvim_lua = true
        }
    })
end
-- LuaFormatter on
