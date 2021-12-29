return function()
    require("telescope").setup({
        defaults = {
            prompt_prefix = " >",
            sorting_strategy = "ascending",
            color_devicons = true,
            layout_config = {
                bottom_pane = {
                    prompt_position = "top",
                },
                center = {
                    prompt_position = "top",
                },
                horizontal = {
                    prompt_position = "top",
                },
                vertical = {
                    prompt_position = "top",
                },
            },
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

    --- TELESCOPE MAPPINGS ---
    local utils = require("juksu.utils")

    local function map_tele(key, f)
        utils.map(
            "n",
            key,
            string.format(
                "<cmd> lua require('juksu.telescope.functions')['%s'](%s)<CR>",
                f,
                ""
            )
        )
    end
    map_tele("<leader>sf", "find_files")
    map_tele("<leader>ss", "live_grep")
    map_tele("<leader>sg", "git_files")

    map_tele("gd", "lsp_definitions")

    map_tele("<leader>lr", "lsp_references")
    map_tele("<leader>la", "lsp_code_actions")
    map_tele("<leader>ld", "diagnostics")
    map_tele("<leader>lD", "workspace_diagnostics")

    map_tele("<leader>gw", "worktrees")
    map_tele("<leader>gn", "create_worktree")
end
