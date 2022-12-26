local M = {
    "nvim-telescope/telescope.nvim",
    dependencies = {
        "nvim-telescope/telescope-file-browser.nvim",
        "nvim-telescope/telescope-fzy-native.nvim",
        { "Juksuu/worktrees.nvim", config = true },
    },
    lazy = false,
}

function M.config()
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
    require("telescope").load_extension("file_browser")
    require("telescope").load_extension("worktrees")

    --- TELESCOPE MAPPINGS ---
    local function map_tele(key, f)
        local rhs = string.format(
            "<cmd>lua RELOAD_RETURN('config.telescope_functions')['%s']()<CR>",
            f
        )
        vim.keymap.set("n", key, rhs)
    end

    map_tele("<leader>sf", "find_files")
    map_tele("<leader>ss", "live_grep")
    map_tele("<leader>sg", "git_files")

    map_tele("<leader>fb", "file_browser")

    map_tele("<leader>lr", "lsp_references")
    map_tele("<leader>df", "diagnostics")
    map_tele("<leader>dw", "workspace_diagnostics")

    map_tele("<leader>gw", "worktrees")
end

return M
