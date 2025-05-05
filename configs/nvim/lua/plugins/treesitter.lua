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
        highlight = {
            enable = true,
            disable = function(_, buf)
                local max_filesize = 500 * 1024 -- 500 KB
                local ok, stats =
                    pcall(vim.uv.fs_stat, vim.api.nvim_buf_get_name(buf))
                if ok and stats and stats.size > max_filesize then
                    return true
                end
            end,
        },
    })
end

return M
