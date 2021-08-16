return function()
    require('telescope').setup {
        defaults = {
            prompt_prefix = ' >',

            sorting_strategy = "descending",
            color_devicons = true

        },
        layout_config = {prompt_position = "top"},

        extensions = {
            fzf = {
                override_generic_sorter = true,
                override_file_sorter = true,
                case_mode = "smart_case"
            }
        }
    }
end

