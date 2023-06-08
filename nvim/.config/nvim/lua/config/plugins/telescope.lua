local M = {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.1",
    event = { "VeryLazy", "BufReadPre" },
    dependencies = {
        "nvim-telescope/telescope-file-browser.nvim",
        { "Juksuu/worktrees.nvim", config = true },
        { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    },
}

function M.config()
    require("telescope").setup({
        defaults = {
            layout_config = {
                prompt_position = "top",
            },
            sorting_strategy = "ascending",
            scroll_strategy = "cycle",
        },
        pickers = {
            find_files = {
                theme = "ivy",
                layout_config = {
                    height = 0.2,
                },
            },
            git_files = {
                theme = "ivy",
                layout_config = {
                    height = 0.2,
                },
            },
        },
    })

    require("telescope").load_extension("fzf")
    require("telescope").load_extension("file_browser")

    -- require("telescope").load_extension("worktrees")

    local builtin = require("telescope.builtin")
    vim.keymap.set("n", "<leader>ss", builtin.live_grep, {})
    vim.keymap.set("n", "<leader>sg", builtin.git_files, {})
    vim.keymap.set("n", "<leader>sf", builtin.find_files, {})

    local file_browser =
        require("telescope").extensions.file_browser.file_browser
    vim.keymap.set("n", "<leader>fb", file_browser, {})

    local list_worktrees =
        require("telescope").extensions.worktrees.list_worktrees
    vim.keymap.set("n", "<leader>gw", list_worktrees, {})
end

return M
