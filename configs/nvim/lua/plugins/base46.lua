require("base46").setup({
    hl_override = {
        NormalFloat = { link = "Normal" },

        NeogitDiffAdd = { link = "DiffAdd" },
        NeogitDiffDelete = { link = "DiffDelete" },
        NeogitDiffDeleteHighlight = { link = "DiffDelete" },
    },
})
vim.cmd.colorscheme("dms")
