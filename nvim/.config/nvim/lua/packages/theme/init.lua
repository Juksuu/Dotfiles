local noice_conf = function()
    require("noice").setup({
        presets = {
            lsp_doc_border = true,
        },
    })
end

return {
    {
        "catppuccin/nvim",
        as = "catppuccin",
        config = require("packages.theme.catppuccin"),
    },
    {
        "folke/noice.nvim",
        requires = {
            "MunifTanjim/nui.nvim",
            "rcarriga/nvim-notify",
        },
        config = noice_conf,
    },
    {
        "feline-nvim/feline.nvim",
        after = { "catppuccin", "noice.nvim" },
        config = require("packages.theme.feline"),
    },
}
