local config = {}

function config.compe()
    require('compe').setup({
        enabled = true,
        -- LuaFormatter off
        source = {
            path = true,
            buffer = true,
            nvim_lsp = true,
            nvim_lua = true
        },
        -- LuaFormatter on
    })
end

return config
