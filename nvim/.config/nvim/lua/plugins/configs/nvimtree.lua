return function()
    require("nvim-tree").setup({
        update_cwd = true,
        git = {
            ignore = false,
        },
    })

    local utils = require("juksu.utils")
    utils.map("n", "<leader>nt", "<cmd> NvimTreeToggle <CR>")
end
