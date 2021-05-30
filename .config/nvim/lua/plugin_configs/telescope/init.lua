return function()
    require('telescope').setup {
        defaults = {
            prompt_prefix = ' >',

            sorting_strategy = "descending",
            prompt_position = "top",
            color_devicons = true

        },

        extensions = {
            fzf = {
                override_generic_sorter = true,
                override_file_sorter = true,
                case_mode = "smart_case"
            }
        }
    }

    require('telescope').load_extension('git_worktree')
end
