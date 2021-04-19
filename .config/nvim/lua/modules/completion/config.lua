local config = {}

function config.compe()
    require('compe').setup({
        enabled = true,
        source = {
            path = true,
            buffer = true,
            nvim_lsp = true,
            nvim_lua = true
        },
    })
end

return config
