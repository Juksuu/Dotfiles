local M = {
    "hrsh7th/nvim-pasta",
    event = "BufReadPost",
}

M.config = function()
    vim.keymap.set({ "n", "x" }, "p", require("pasta.mappings").p)
    vim.keymap.set({ "n", "x" }, "P", require("pasta.mappings").P)

    require("pasta").setup({})
end

return M
