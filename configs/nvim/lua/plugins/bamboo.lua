local M = {
    "ribru17/bamboo.nvim",
    priority = 1000,
}

function M.config()
    require("bamboo").setup()
    require("bamboo").load()
end

return M
