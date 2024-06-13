local M = {
    "folke/trouble.nvim",
    event = "VeryLazy",
    dependencies = {
        { "folke/todo-comments.nvim", config = true },
    },
}

function M.config()
    require("trouble").setup({
        auto_close = true,
    })

    local trouble_jump = function(next)
        local trouble = require("trouble")
        if trouble.is_open() then
            local func = next and trouble.next or trouble.prev
            func({ skip_groups = true, jump = true })
        end
    end

    vim.keymap.set("n", "]q", function()
        trouble_jump(true)
    end)
    vim.keymap.set("n", "[q", function()
        trouble_jump(false)
    end)

    vim.keymap.set("n", "<leader>dd", function()
        require("trouble").toggle("diagnostics")
    end)
    vim.keymap.set("n", "<leader>tt", "<cmd> TodoTrouble<cr>")
end

return M
