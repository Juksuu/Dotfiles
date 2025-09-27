local M = {
    "saghen/blink.cmp",
    lazy = false,
    dependencies = {
        "rafamadriz/friendly-snippets",
        {
            "mikavilpas/blink-ripgrep.nvim",
            version = "*", -- use the latest stable version
        },
    },
    build = "nix run .#build-plugin --accept-flake-config",
}

function M.config()
    require("blink.cmp").setup({
        signature = { enabled = true },
        cmdline = {
            enabled = false,
        },
        sources = {
            default = { "lsp", "path", "snippets", "buffer", "ripgrep" },
            providers = {
                ripgrep = {
                    module = "blink-ripgrep",
                    name = "Ripgrep",
                    ---@module "blink-ripgrep"
                    ---@type blink-ripgrep.Options
                    opts = {
                        backend = {
                            use = "gitgrep-or-ripgrep",
                        },
                    },
                },
            },
        },
    })
end

return M
