local should_reload = true
local reloader = function()
    if should_reload then
        RELOAD('plenary')
        RELOAD('popup')
        RELOAD('telescope')
    end
end

reloader()

local actions = require('telescope.actions')
local sorters = require('telescope.sorters')
local themes = require('telescope.themes')

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
                ["<esc>"] = actions.close,
                ["<C-x>"] = false,
                ["<C-s>"] = actions.file_vsplit,

                -- Experimental
                ["<tab>"] = actions.toggle_selection,

                ["<C-q>"] = actions.send_to_qflist,
                ["<M-q>"] = actions.send_selected_to_qflist,
            },
        },

        borderchars = {
            { '─', '│', '─', '│', '╭', '╮', '╯', '╰'},
            preview = { '─', '│', '─', '│', '╭', '╮', '╯', '╰'},
        },

        file_sorter = sorters.get_fzy_sorter,

        file_previewer   = require('telescope.previewers').vim_buffer_cat.new,
        grep_previewer   = require('telescope.previewers').vim_buffer_vimgrep.new,
        qflist_previewer = require('telescope.previewers').vim_buffer_qflist.new,
    },

    extensions = {
        fzy_native = {
            override_generic_sorter = false,
            override_file_sorter = true,
        },

        fzf_writer = {
            use_highlighter = false,
            minimum_grep_characters = 4,
        }
    },
}

require('telescope').load_extension('fzy_native')

local M = {}
function M.edit_neovim()
    require('telescope.builtin').find_files {
        prompt_title = "~ Nvim config ~",
        shorten_path = true,
        cwd = "~/.config/nvim",
        width = .25,

        layout_strategy = 'horizontal',
        layout_config = {
            preview_width = 0.65,
        },
    }
end

function M.fd()
    require('telescope.builtin').fd()
end

function M.git_files()
    local opts = themes.get_dropdown {
        winblend = 10,
        border = true,
        previewer = false,
        shorten_path = false,
    }

    require('telescope.builtin').git_files(opts)
end

function M.live_grep()
    require('telescope.builtin').live_grep {
        shorten_path = true,
        fzf_separator = "|>",
    }
end

function M.buffers()
    require('telescope.builtin').buffers {
        shorten_path = false,
    }
end

function M.curbuf()
    local opts = themes.get_dropdown {
        winblend = 10,
        border = true,
        previewer = false,
        shorten_path = false,

        -- layout_strategy = 'current_buffer',
    }
    require('telescope.builtin').current_buffer_fuzzy_find(opts)
end

return setmetatable({}, {
        __index = function(_, k)
            reloader()

            if M[k] then
                return M[k]
            else
                return require('telescope.builtin')[k]
            end
        end
    })
