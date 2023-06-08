local M = {
    "KadoBOT/nvim-spotify",
    build = "make",
    event = { "VeryLazy", "BufReadPre" },
}

M.config = function()
    require("nvim-spotify").setup({
        -- default opts
        status = {
            update_interval = 10000, -- the interval (ms) to check for what's currently playing
            format = "%s %t by %a", -- spotify-tui --format argument
        },
    })

    vim.api.nvim_set_keymap("n", "<leader>sn", "<Plug>(SpotifySkip)", {})
    vim.api.nvim_set_keymap("n", "<leader>sb", "<Plug>(SpotifyPrev)", {})
    vim.api.nvim_set_keymap("n", "<leader>sp", "<Plug>(SpotifyPause)", {})
end

return M
