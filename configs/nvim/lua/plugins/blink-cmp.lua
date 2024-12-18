local M = {
    "saghen/blink.cmp",
    lazy = false,
    dependencies = "rafamadriz/friendly-snippets",
    build = "nix run .#build-plugin",
}

function M.config()
    require("blink.cmp").setup({
        signature = { enabled = true },
        sources = {
            cmdline = {},
        },
    })
end

return M
