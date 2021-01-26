local lspconfig = require "lspconfig"

vim.g.completion_matching_smart_case = 1
vim.g.completion_matching_strategy_list = {"exact", "substring"}

local on_attach = function(client)
    print("'" .. client.name .. "' language server started" );
    require'completion'.on_attach(client)
end

-- https://github.com/theia-ide/typescript-language-server
lspconfig.tsserver.setup{ on_attach = on_attach }

-- https://github.com/microsoft/pyright
lspconfig.pyright.setup{ on_attach = on_attach }

local eslint = require "efm/eslint"
local tslint = require "efm/tslint"

-- https://github.com/mattn/efm-langserver
 lspconfig.efm.setup {
     on_attach = on_attach,
     settings = {
         rootMarkers = { ".git/", "package.json" },
         languages = {
             typescript = { eslint, tslint },
             javascript = { eslint, tslint },
             typescriptreact = { eslint, tslint },
             javascriptreact = { eslint, tslint }
         }
     }
 }
