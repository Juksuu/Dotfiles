-- LuaFormatter off
return function()
    require('compe').setup({
        enabled = true,
        source = {
            calc = true,
            path = true,
            vsnip = true,
            buffer = true,
            nvim_lsp = true,
            nvim_lua = true,
        }
    })
end
-- LuaFormatter on
