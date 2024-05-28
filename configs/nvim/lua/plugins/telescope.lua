local M = {
    "nvim-telescope/telescope.nvim",
    dependencies = {
        "nvim-telescope/telescope-file-browser.nvim",
    },
    keys = {
        "<leader>ss",
        "<leader>sg",
        "<leader>sf",
        "<leader>fb",
        "<leader>gw",
    },
}

function M.config()
    require("telescope").setup({
        defaults = {
            sort_mru = true,
            sorting_strategy = "ascending",
            hl_result_eol = true,
            layout_config = {
                prompt_position = "top",
            },
            border = true,
            -- stylua: ignore
            borderchars = {
                prompt = { "▔", "▕", " ", "▏", "🭽", "🭾", "▕", "▏", },
                results = { "▔", "▕", "▁", "▏", "🭽", "🭾", "🭿", "🭼", },
                preview = { "▔", "▕", "▁", "▏", "🭽", "🭾", "🭿", "🭼", },
            },
        },
        pickers = {
            find_files = {
                hidden = true,
            },
            git_files = {
                hidden = true,
            },
        },
        extensions = {
            file_browser = {
                hidden = {
                    file_browser = true,
                    folder_browser = true,
                },
            },
        },
    })

    require("telescope").load_extension("file_browser")
    require("telescope").load_extension("worktrees")

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
