-- LuaFormatter off
return function()
    require('nvim-treesitter.configs').setup {
        ensure_installed = 'all',
        highlight = {
            enable = true,
            additional_vim_regex_highlighting = true
        },
        indent = {
            enable = false
        },
        refactor = {
            highlight_definitions = {
                enable = true
            },
        }
    }
end
-- LuaFormatter on
