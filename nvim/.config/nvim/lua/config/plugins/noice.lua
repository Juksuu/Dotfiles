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
    })
end

return M
