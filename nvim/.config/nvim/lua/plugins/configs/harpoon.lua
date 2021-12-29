return function()
    local utils = require("juksu.utils")
    utils.map(
        "n",
        "<leader>th",
        "<cmd> lua require('harpoon.term').gotoTerminal(1)<CR>"
    )
    utils.map(
        "n",
        "<leader>tj",
        "<cmd> lua require('harpoon.term').gotoTerminal(2)<CR>"
    )
    utils.map(
        "n",
        "<leader>tk",
        "<cmd> lua require('harpoon.term').gotoTerminal(3)<CR>"
    )

    utils.map("n", "<C-j>", "<cmd> lua require('harpoon.ui').nav_file(1)<CR>")
    utils.map("n", "<C-k>", "<cmd> lua require('harpoon.ui').nav_file(2)<CR>")
    utils.map(
        "n",
        "<leader>ma",
        "<cmd> lua require('harpoon.mark').add_file()<CR>"
    )
    utils.map(
        "n",
        "<leader>mm",
        "<cmd> lua require('harpoon.ui').toggle_quick_menu()<CR>"
    )
end
