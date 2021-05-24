require('telescope').setup {
    defaults = {
        prompt_prefix = ' >',

        winblend = 0,
        preview_cutoff = 120,

        layout_strategy = 'horizontal',
        layout_defaults = {
            horizontal = {
                width_padding = 0.1,
                height_padding = 0.1,
                preview_width = 0.6,
            },
            vertical = {
                width_padding = 0.05,
                height_padding = 1,
                preview_height = 0.5,
            }
        },

        selection_strategy = "reset",
        sorting_strategy = "descending",
        scroll_strategy = "cycle",
        prompt_position = "top",
        color_devicons = true,

        mappings = {
            i = {
                ["<esc>"] = require('telescope.actions').close,
                ["<C-s>"] = require('telescope.actions').file_vsplit,

                -- Experimental
                ["<C-q>"] = require('telescope.actions').send_to_qflist,
                ["<M-q>"] = require('telescope.actions').send_selected_to_qflist,
            },
        },

        borderchars = {
            { '─', '│', '─', '│', '╭', '╮', '╯', '╰'},
            preview = { '─', '│', '─', '│', '╭', '╮', '╯', '╰'},
        },

        file_sorter = require('telescope.sorters').get_fzy_sorter,
    },

    extensions = {
        fzf = {
            override_generic_sorter = true,
            override_file_sorter = true,
            case_mode = "smart_case",
        },
    },
}

require('telescope').load_extension('git_worktree')

local M = {}

function M.find_files()
    require('telescope.builtin').find_files()
end

function M.git_files()
    local opts = require('telescope.themes').get_dropdown {
        -- border = true,
        previewer = false,
        shorten_path = false,
    }

    require('telescope.builtin').git_files(opts)
end

function M.git_worktrees()
    require('telescope').extensions.git_worktree.git_worktrees()
end

function M.create_git_worktree()
    require('telescope').extensions.git_worktree.create_git_worktree()
end

function M.live_grep()
    require('telescope.builtin').live_grep {
        shorten_path = true,
    }
end

function M.buffers()
    require('telescope.builtin').buffers {
        shorten_path = false,
    }
end

function M.curbuf()
    local opts = require('telescope.themes').get_dropdown {
        winblend = 10,
        border = true,
        previewer = false,
        shorten_path = false,
    }
    require('telescope.builtin').current_buffer_fuzzy_find(opts)
end

return setmetatable({}, {
    __index = function(_, k)
        if M[k] then
            return M[k]
        else
            return require('telescope.builtin')[k]
        end
    end
})
