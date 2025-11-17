require("blink.cmp").setup({
    signature = { enabled = true },
    cmdline = {
        enabled = false,
    },
    sources = {
        default = { "lsp", "path", "snippets", "ripgrep" },
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
                score_offset = -2,
            },
            lsp = {
                -- You may enable the buffer source, when LSP is available, by setting this to `{}`
                -- You may want to set the score_offset of the buffer source to a lower value, such as -5 in this case
                fallbacks = { "ripgrep" },
            },
        },
    },
})
