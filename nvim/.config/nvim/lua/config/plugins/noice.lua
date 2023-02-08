local M = {
    "folke/noice.nvim",
    dependencies = {
        "MunifTanjim/nui.nvim",
        "rcarriga/nvim-notify",
    },
    event = { "VeryLazy", "BufReadPre" },
}

function M.config()
    require("noice").setup({
        presets = {
            lsp_doc_border = true,
        },
        messages = {
            enabled = true,
            view = "mini",
            view_error = "mini",
            view_warn = "mini",
        },
        lsp = {
            message = {
                view = "mini",
            },
        },
        notify = {
            enabled = false,
        },
    })
end

return M
