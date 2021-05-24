local config = {}

-- LuaFormatter off

function config.lspconfig()
    require('modules.lsp.lsp')
end

function config.lspsaga()
    require("lspsaga").init_lsp_saga()
end

function config.lspstatus()
    require('lsp-status').register_progress()
end

function config.lspkind()
    require('lspkind').init({})
end

-- LuaFormatter on

return config
