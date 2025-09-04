local M = {
    "folke/snacks.nvim",
    priority = 1000,
}

function M.config()
    require("snacks").setup({
        bigfile = { enabled = true },
        indent = { enabled = true },
        quickfile = { enabled = true },
        scope = { enabled = true },
        scroll = { enabled = true },
        words = { enabled = true },
        picker = { enabled = true },
    })


    -- stylua: ignore start
    -- Keymaps for snacks modules
    vim.keymap.set("n", "<leader>s", function() Snacks.scratch() end)
    vim.keymap.set("n", "<leader>ss", function() Snacks.scratch.select() end)
    vim.keymap.set("n", "<leader>bd", function() Snacks.bufdelete() end)
    vim.keymap.set("n", "<leader>gb", function() Snacks.git.blame_line() end)
    vim.keymap.set("n", "]]", function() Snacks.words.jump(vim.v.count1) end)
    vim.keymap.set("n", "[[", function() Snacks.words.jump(-vim.v.count1) end)
    -- stylua: ignore end

    -- stylua: ignore start
    -- Keymaps for snacks pickers
    vim.keymap.set("n", "<leader>ss", function() Snacks.picker.grep() end)
    vim.keymap.set("n", "<leader>sg", function() Snacks.picker.git_files() end)
    vim.keymap.set("n", "<leader>sf", function() Snacks.picker.files() end)
    -- stylua: ignore end

    -- stylua: ignore start
    -- Keymaps for custom pickers
    vim.keymap.set("n", "<leader>gw", function() Snacks.picker.worktrees() end)
    -- stylua: ignore end
end

function M.init()
    vim.api.nvim_create_autocmd("User", {
        pattern = "VeryLazy",
        callback = function()
            -- Setup some globals for debugging (lazy-loaded)
            _G.dd = function(...)
                Snacks.debug.inspect(...)
            end
            _G.bt = function()
                Snacks.debug.backtrace()
            end
            vim.print = _G.dd -- Override print to use snacks for `:=` command

            -- Create some toggle mappings
            Snacks.toggle.diagnostics():map("<leader>td")
            Snacks.toggle.inlay_hints():map("<leader>tih")
            Snacks.toggle.indent():map("<leader>til")
        end,
    })
end

return M
