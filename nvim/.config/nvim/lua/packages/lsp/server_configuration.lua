local M = {}

M.server_settings = {
    sumneko_lua = {
        settings = {
            Lua = {
                runtime = {
                    -- Use correct version of lua
                    version = "LuaJIT",
                },
                diagnostics = {
                    globals = {
                        -- Recognize global `vim` variables
                        "vim",
                    },
                },
                workspace = {
                    library = vim.api.nvim_get_runtime_file("", true),
                },
                telemetry = {
                    enable = false,
                },
            },
        },
    },
}

return M
