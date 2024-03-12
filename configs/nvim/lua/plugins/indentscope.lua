local M = {
    "echasnovski/mini.indentscope",
    event = "VeryLazy",
}

function M.init()
    vim.api.nvim_create_autocmd("FileType", {
        pattern = {
            "help",
            "lazy",
        },
        callback = function()
            vim.b.miniindentscope_disable = true
        end,
    })
end

function M.config()
    require("mini.indentscope").setup({
        symbol = "│",
        options = { try_as_border = true },
    })
end

return M
