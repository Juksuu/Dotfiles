local config = {}

function config.lspconfig()
    require('modules.lsp.lsp')
end

function config.lspsaga()
    require("lspsaga").init_lsp_saga()
end

function config.lspstatus()
    require('lsp-status').register_progress()
end

return config
