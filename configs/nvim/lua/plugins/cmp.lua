local M = {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-nvim-lsp",

        "onsails/lspkind-nvim",
    },
}

M.config = function()
    vim.api.nvim_set_hl(0, "CmpGhostText", { link = "Comment", default = true })

    local cmp = require("cmp")
    local lspkind = require("lspkind")

    local defaults = require("cmp.config.default")()
    local cmp_info_style = cmp.config.window.bordered({
        border = "rounded",
    })

    local opts = {
        completion = {
            completeopt = "menu,menuone,noinsert",
        },
        snippet = {
            expand = function(args)
                require("luasnip").lsp_expand(args.body)
            end,
        },
        mapping = cmp.mapping.preset.insert({
            ["<C-n>"] = cmp.mapping.select_next_item({
                behavior = cmp.SelectBehavior.Insert,
            }),
            ["<C-p>"] = cmp.mapping.select_prev_item({
                behavior = cmp.SelectBehavior.Insert,
            }),
            ["<C-b>"] = cmp.mapping.scroll_docs(-4),
            ["<C-f>"] = cmp.mapping.scroll_docs(4),
            ["<C-e>"] = cmp.mapping.abort(),
            ["<C-y>"] = cmp.mapping.confirm({ select = true }),
        }),
        sources = cmp.config.sources({
            { name = "path" },
            { name = "nvim_lsp" },
            { name = "luasnip" },
            { name = "buffer" },
        }),
        experimental = {
            ghost_text = {
                hl_group = "CmpGhostText",
            },
        },
        sorting = defaults.sorting,
        -- Taken from ribru17/.dotfiles
        window = {
            completion = cmp_info_style,
            documentation = cmp_info_style,
        },
        formatting = {
            fields = { "abbr", "menu", "kind" },
            format = lspkind.cmp_format({
                mode = "symbol_text",
                -- The function below will be called before any actual modifications
                -- from lspkind so that you can provide more controls on popup
                -- customization.
                -- (See [#30](https://github.com/onsails/lspkind-nvim/pull/30))
                before = function(_, vim_item)
                    local width = 30
                    local ellipses_char = "…"
                    local label = vim_item.abbr
                    local truncated_label = vim.fn.strcharpart(label, 0, width)
                    if truncated_label ~= label then
                        vim_item.abbr = truncated_label .. ellipses_char
                    elseif string.len(label) < width then
                        local padding =
                            string.rep(" ", width - string.len(label))
                        vim_item.abbr = label .. padding
                    end
                    return vim_item
                end,
                menu = {
                    path = "[Path]",
                    buffer = "[Buffer]",
                    nvim_lsp = "[LSP]",
                    luasnip = "[Snip]",
                },
            }),
        },
    }

    cmp.setup(opts)
end

return M
