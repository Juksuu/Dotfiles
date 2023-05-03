local luasnip_conf = function()
    require("luasnip").config.set_config({
        history = true,
    })
    require("luasnip/loaders/from_vscode").lazy_load({
        paths = {
            "~/.local/share/nvim/site/pack/packer/start/friendly-snippets",
        },
    })

    vim.keymap.set({ "n", "s", "i" }, "<C-h>", function()
        require("luasnip").jump(-1)
    end)
    vim.keymap.set({ "n", "s", "i" }, "<C-l>", function()
        require("luasnip").jump(1)
    end)
end

local M = {
    "hrsh7th/nvim-cmp",
    dependencies = {
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-nvim-lua",
        "lukas-reineke/cmp-rg",
        "lukas-reineke/cmp-under-comparator",

        "onsails/lspkind-nvim",

        {
            "tzachar/cmp-tabnine",
            build = "./install.sh",
            config = function()
                require("cmp_tabnine.config"):setup()
            end,
        },

        {
            "L3MON4D3/LuaSnip",
            dependencies = "rafamadriz/friendly-snippets",
            config = luasnip_conf,
        },
        "saadparwaiz1/cmp_luasnip",
    },
    event = "BufReadPost",
}

function M.config()
    local cmp = require("cmp")
    local lspkind = require("lspkind")

    cmp.setup({
        snippet = {
            expand = function(args)
                require("luasnip").lsp_expand(args.body)
            end,
        },
        mapping = {
            ["<C-n>"] = cmp.mapping.select_next_item(),
            ["<C-p>"] = cmp.mapping.select_prev_item(),
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
            { name = "cmp_tabnine" },
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
        window = {
            completion = cmp.config.window.bordered({
                col_offset = -3,
                side_padding = 0,
                winhighlight = "Normal:Normal,FloatBorder:FloatBorder,CursorLine:Visual,Search:None",
            }),
            documentation = cmp.config.window.bordered({
                winhighlight = "Normal:Normal,FloatBorder:FloatBorder,CursorLine:Visual,Search:None",
            }),
        },
        formatting = {
            fields = { "kind", "abbr", "menu" },
            format = function(entry, vim_item)
                local kind = lspkind.cmp_format({
                    mode = "symbol_text",
                    maxwidth = 50,
                })(entry, vim_item)

                local strings = vim.split(kind.kind, "%s", { trimempty = true })
                kind.kind = " " .. (strings[1] or "") .. " "
                kind.menu = "    (" .. (strings[2] or "") .. ")"

                return kind
            end,
        },
    })
end

return M
