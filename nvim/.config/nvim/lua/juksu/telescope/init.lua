return function()
    require("telescope").setup({
        defaults = {
            prompt_prefix = "❯ ",
            selection_caret = "❯ ",

            borderchars = { " ", " ", " ", " ", "", "", "", "" },

            layout_strategy = "horizontal",
            layout_config = {
                prompt_position = "top",
                width = 0.8,
            },

            selection_strategy = "reset",
            sorting_strategy = "ascending",
            scroll_strategy = "cycle",
            color_devicons = true,
        },
    })

    require("telescope").load_extension("fzy_native")
    require("telescope").load_extension("worktrees")
    require("telescope").load_extension("file_browser")

    --- TELESCOPE MAPPINGS ---
    local function map_tele(key, f)
        vim.keymap.set(
            "n",
            key,
            require("juksu.utils").reload_module("juksu.telescope.functions")[f]
        )
    end

    map_tele("<leader>sf", "find_files")
    map_tele("<leader>ss", "live_grep")
    map_tele("<leader>sg", "git_files")

    map_tele("<leader>fb", "file_browser")

    map_tele("<leader>lr", "lsp_references")
    map_tele("<leader>la", "lsp_code_actions")
    map_tele("<leader>df", "diagnostics")
    map_tele("<leader>dw", "workspace_diagnostics")

    map_tele("<leader>gw", "worktrees")
end
