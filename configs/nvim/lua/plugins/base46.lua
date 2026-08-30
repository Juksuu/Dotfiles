require("base46").setup({
    hl_override = {
        NormalFloat = { link = "Normal" },

        NeogitDiffAdd = { link = "DiffAdd" },
        NeogitDiffAddHighlight = { link = "DiffAdd" },
        NeogitDiffDelete = { link = "DiffDelete" },
        NeogitDiffDeleteHighlight = { link = "DiffDelete" },
    },
    hl_add = {
        SnacksPickerListCursorLine = { link = "Pmenu" },
    },
})
vim.cmd.colorscheme("dms")
