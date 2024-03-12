local M = {
    "lukas-reineke/indent-blankline.nvim",
    event = "VeryLazy",
    main = "ibl",
}

function M.config()
    require("ibl").setup({
        indent = {
            char = "│",
            tab_char = "│",
        },
        scope = { enabled = false },
        exclude = {
            filetypes = {
                "help",
                "lazy",
            },
        },
    })
end

return M
