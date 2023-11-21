local M = {
    "hrsh7th/nvim-pasta",
    event = "BufReadPost",
}

M.config = function()
    vim.keymap.set({ "n", "x" }, "p", require("pasta.mapping").p)
    vim.keymap.set({ "n", "x" }, "P", require("pasta.mapping").P)
end

return M
