return function()
    require('nvim-treesitter.configs').setup {
        ensure_installed = 'all',
        highlight = {enable = true, disable = {"json", "svelte"}},
        indent = {enable = false}
    }
end
