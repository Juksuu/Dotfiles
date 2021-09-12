-- LuaFormatter off
return function()
    require('telescope').setup {
        defaults = {
            prompt_prefix = ' >',

            sorting_strategy = "descending",
            color_devicons = true

        },
        layout_config = {
            prompt_position = "top"
        }
    }
end
-- LuaFormatter on