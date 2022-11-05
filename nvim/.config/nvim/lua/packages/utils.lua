local comment_conf = function()
    require("Comment").setup()
end

local indent_conf = function()
    require("guess-indent").setup()
end

local autopairs_conf = function()
    require("nvim-autopairs").setup({
        map_cr = true,
    })
end

local ts_conf = function()
    require("nvim-treesitter.configs").setup({
        ensure_installed = "all",
        highlight = {
            enable = true,
        },
    })
end

local ts_context_conf = function()
    require("treesitter-context").setup({
        enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
        patterns = { -- Match patterns for TS nodes. These get wrapped to match at word boundaries.
            -- For all filetypes
            -- Note that setting an entry here replaces all other patterns for this entry.
            -- By setting the 'default' entry below, you can control which nodes you want to
            -- appear in the context window.
            default = {
                "class",
                "function",
                "method",
                "for",
                "while",
                "if",
                "switch",
                "case",
            },

            -- Patterns for specific filetypes
            -- If a pattern is missing, *open a PR* so everyone can benefit.
            rust = {
                "loop_expression",
                "impl_item",
            },

            typescript = {
                "class_declaration",
                "abstract_class_declaration",
                "else_clause",
            },
        },
    })
end

return {
    -- Impatient for lua module optimizations
    { "lewis6991/impatient.nvim" },

    { "nvim-lua/plenary.nvim" },
    { "kyazdani42/nvim-web-devicons" },

    { "tpope/vim-surround" },
    { "gpanders/editorconfig.nvim" },
    { "maxbrunsfeld/vim-yankstack" },

    { "numToStr/Comment.nvim", config = comment_conf },
    { "nmac427/guess-indent.nvim", config = indent_conf },
    { "windwp/nvim-autopairs", config = autopairs_conf },

    { "nvim-treesitter/nvim-treesitter", config = ts_conf },
    {
        "nvim-treesitter/nvim-treesitter-context",
        after = "nvim-treesitter",
        config = ts_context_conf,
    },
}
