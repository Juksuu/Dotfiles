return function()
    require("telescope").setup({
        defaults = {
            prompt_prefix = " >",

            sorting_strategy = "descending",
            color_devicons = true,
        },
        layout_config = {
            prompt_position = "top",
        },
        extensions = {
            fzf = {
                fuzzy = true,
                override_generic_sorter = true,
                override_file_sorter = true,
                case_mode = "smart_case",
            },
        },
    })

    require("telescope").load_extension("fzf")
    require("telescope").load_extension("git_worktree")
end
