local config = {}

function config.polyglot()
    vim.g.vim_svelte_plugin_load_full_syntax = 1
    vim.g.vim_svelte_plugin_use_typescript = 1
    vim.g.vim_svelte_plugin_use_sass = 1
end

function config.treesitter()
    require('nvim-treesitter.configs').setup {
        ensure_installed = { 
            'lua',
            'graphql',
            'html',
            'javascript',
            'python',
            'rust',
            'typescript'
        },
        highlight = {
            enable = true,
            use_languagetree = false,
            disable = { "json", "svelte" },
        },
        indent = {
            enable = false
        }
    }
end

return config
