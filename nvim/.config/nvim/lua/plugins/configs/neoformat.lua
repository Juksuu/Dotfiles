return function()
    local utils = require("juksu.utils")

    vim.g.neoformat_try_node_exe = 1
    vim.g.neoformat_only_msg_on_error = true
    vim.g.neoformat_enabled_lua = { "stylua" }

    utils.create_autocommands({
        format = { { "BufWritePre", "*", "Neoformat" } },
    })
end
