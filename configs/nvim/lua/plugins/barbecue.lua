local M = {
    "utilyre/barbecue.nvim",
    event = { "BufReadPost", "BufNewFile", "BufWritePre" },
    dependencies = {
        "SmiteshP/nvim-navic",
    },
}

function M.config()
    require("barbecue").setup({
        theme = "catppucin",
        kinds = {
            Array = "",
            Boolean = "",
            Class = "",
            Color = "",
            Constant = "",
            Constructor = "",
            Enum = "",
            EnumMember = "",
            Event = "",
            Field = "",
            File = "󰈙",
            Folder = "",
            Function = "",
            Interface = "",
            Key = "",
            Keyword = "",
            Method = "",
            Module = "",
            Namespace = "",
            Null = "",
            Number = "",
            Object = "",
            Operator = "",
            Package = "",
            Property = "",
            Reference = "",
            Snippet = "",
            String = "",
            Struct = "",
            Text = "",
            TypeParameter = "",
            Unit = "",
            Value = "",
            Variable = "",
        },
    })
end

return M
