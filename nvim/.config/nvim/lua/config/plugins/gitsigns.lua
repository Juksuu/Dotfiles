local M = {
    "lewis6991/gitsigns.nvim",
    event = "BufReadPre",
}

function M.config()
    local gs = require("gitsigns")
    gs.setup({
        on_attach = function(bufnr)
            local function map(mode, l, r, opts)
                opts = opts or {}
                opts.buffer = bufnr
                vim.keymap.set(mode, l, r, opts)
            end

            map({ "n", "v" }, "<leader>hs", gs.stage_hunk)
            map({ "n", "v" }, "<leader>hr", gs.reset_hunk)
            map("n", "<leader>hS", gs.stage_buffer)
            map("n", "<leader>hu", gs.undo_stage_hunk)
            map("n", "<leader>hR", gs.reset_buffer)
            map("n", "<leader>hb", gs.toggle_current_line_blame)
            map("n", "<leader>hst", gs.toggle_signs)
        end,
    })
end

return M
