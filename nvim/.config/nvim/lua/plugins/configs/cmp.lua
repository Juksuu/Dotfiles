return function()
    local cmp = require("cmp")
    local lspkind = require("lspkind")

    cmp.setup({
        snippet = {
            expand = function(args)
                require("luasnip").lsp_expand(args.body)
            end,
        },
        mapping = {
            ["<C-d>"] = cmp.mapping.scroll_docs(-4),
            ["<C-f>"] = cmp.mapping.scroll_docs(4),
            ["<C-e>"] = cmp.mapping.close(),
            ["<c-y>"] = cmp.mapping(
                cmp.mapping.confirm({
                    behavior = cmp.ConfirmBehavior.Insert,
                    select = true,
                }),
                { "i", "c" }
            ),

            ["<c-space>"] = cmp.mapping({
                i = cmp.mapping.complete(),
                c = function(
                    _ --[[fallback]]
                )
                    if cmp.visible() then
                        if not cmp.confirm({ select = true }) then
                            return
                        end
                    else
                        cmp.complete()
                    end
                end,
            }),
        },
        sources = {
            { name = "nvim_lua" },
            { name = "nvim_lsp" },
            { name = "path" },
            { name = "luasnip" },
            { name = "buffer", keyword_length = 5 },
            { name = "rg", keyword_length = 5 },
        },
        sorting = {
            comparators = {
                cmp.config.compare.offset,
                cmp.config.compare.exact,
                cmp.config.compare.score,
                require("cmp-under-comparator").under,
                cmp.config.compare.kind,
                cmp.config.compare.sort_text,
                cmp.config.compare.length,
                cmp.config.compare.order,
            },
        },
        formatting = {
            format = lspkind.cmp_format({
                with_text = true,
                menu = {
                    buffer = "[buf]",
                    nvim_lsp = "[Lsp]",
                    nvim_lua = "[vim_api]",
                    path = "[path]",
                    luasnip = "[snip]",
                    rg = "[rg]",
                },
            }),
        },
    })
end
