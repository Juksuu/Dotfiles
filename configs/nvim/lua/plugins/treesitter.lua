local M = {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
}

function M.config()
    ---@type TSConfig
    ---@diagnostic disable-next-line: missing-fields
    require("nvim-treesitter.configs").setup({
        ensure_installed = {
            "vim",
            "lua",
        },
        auto_install = true,
        highlight = { enable = true },
    })
end

return M
