require "lsp"

require "colorizer".setup()

local actions = require('telescope.actions')
require('telescope').setup({
    defaults = {
        file_sorter = require('telescope.sorters').get_fzy_sorter,
        mappings = {
            i = {
                ["<esc>"] = actions.close,
                ["<c-k>"] = actions.move_selection_next,
                ["<c-j>"] = actions.move_selection_prev,
            }
        }
    }
})

