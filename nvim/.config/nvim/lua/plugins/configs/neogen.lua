return function()
    require("neogen").setup({
        enabled = true,
    })

    local utils = require("juksu.utils")
    utils.map("n", "<leader>ng", "<cmd> lua require('neogen').generate()<CR>")
end
