return function()
    require("neogit").setup()

    local utils = require("juksu.utils")
    utils.map("n", "<leader>gs", "<cmd> lua require('neogit').open() <CR>")
end
