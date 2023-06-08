local M = {
    "folke/noice.nvim",
    event = { "VeryLazy", "BufReadPre" },
    dependencies = {
        "MunifTanjim/nui.nvim",
    },
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
        message = {
            view = nil,
        },
        notify = {
            enabled = false,
        },
        lsp = {
            message = {
                enabled = false,
            },
        },
    })
end

return M
