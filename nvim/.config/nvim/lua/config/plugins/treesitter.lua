local M = {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = "BufReadPre",
}

function M.config()
    require("nvim-treesitter.configs").setup({
        ensure_installed = {
            "vim",
            "lua",
        },
        auto_install = true,
        indent = { enable = false },
        highlight = { enable = true, additional_vim_regex_highlighting = false },
        incremental_selection = { enable = false },
    })
end

return M
