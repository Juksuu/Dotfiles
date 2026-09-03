require("blink.cmp").setup({
    signature = { enabled = true },
    cmdline = {
        enabled = false,
    },
    sources = {
        default = { "lazydev", "lsp", "path", "snippets", "ripgrep" },
        providers = {
            lazydev = {
                name = "LazyDev",
                module = "lazydev.integrations.blink",
                -- make lazydev completions top priority (see `:h blink.cmp`)
                score_offset = 100,
            },
            ripgrep = {
                module = "blink-ripgrep",
                name = "Ripgrep",
                ---@module "blink-ripgrep"
                ---@type blink-ripgrep.Options
                opts = {
                    backend = {
                        use = "gitgrep-or-ripgrep",
                        gitgrep = {
                            additional_gitgrep_options = {
                                -- exclude files marked with the 'blink-ripgrep-ignore' attribute in
                                -- .gitattributes
                                ":(exclude,attr:ripgrep-ignore)",
                            },
                        },
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
    fuzzy = { implementation = "rust" },
})
