local M = {
    "hrsh7th/nvim-pasta",
}

M.config = function()
    vim.keymap.set({ "n", "x" }, "p", require("pasta.mappings").p)
    vim.keymap.set({ "n", "x" }, "P", require("pasta.mappings").P)
    vim.keymap.set({ "n" }, "<C-p>", require("pasta.mappings").toggle_pin)

    require("pasta").setup({})
end

return M
