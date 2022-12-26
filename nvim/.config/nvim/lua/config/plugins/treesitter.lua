local M = {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = "BufReadPost",
}

function M.config()
    require("nvim-treesitter.configs").setup({
        ensure_installed = "all",
        auto_install = false,
        indent = { enable = false },
        highlight = { enable = true },
        incremental_selection = { enable = false },
    })
end

return M
