local M = {
    "nvimdev/guard.nvim",
    event = "BufReadPost"
}

function M.config()
    local ft = require("guard.filetype")

    ft('lua'):fmt('stylua')

    require('guard').setup({
        fmt_on_save = true,
        lsp_as_default_formatter = true
    })
end

return M
