local M = {
    "stevearc/conform.nvim",
    event = "BufReadPost",
}

function M.config()
    require("conform").setup({
        formatters_by_ft = {
            lua = { "stylua" },
            zig = { "zigfmt" },
            nix = { "nixfmt" },
            ["*"] = { "codespell" },
            ["_"] = { "trim_whitespace" },
        },
        format_on_save = nil,
    })
end

return M
