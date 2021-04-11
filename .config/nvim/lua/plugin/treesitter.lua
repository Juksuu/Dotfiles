require('nvim-treesitter.configs').setup {
    ensure_installed = { 
        'lua',
        'graphql',
        'html',
        'javascript',
        'python',
        'rust',
        'svelte',
        'typescript'
    },
    highlight = {
        enable = true, -- false will disable the whole extension
        use_languagetree = false,
        disable = {"json"},
    },
    indent = {
        enable = true
    }
}
