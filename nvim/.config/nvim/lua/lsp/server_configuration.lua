local M = {}

-- Servers in the form {server = string, docker = boolean}
M.servers = {
    { server = "gopls", docker = false },
    { server = "pylsp", docker = false },
    { server = "svelte", docker = false },
    { server = "yamlls", docker = false },
    { server = "eslint", docker = false },
    { server = "rust_analyzer", docker = false },

    { server = "tsserver", docker = true },
    { server = "sumneko_lua", docker = true },
}

M.custom_docker_settings = {}

M.custom_server_settings = {
    rust_analyzer = {
        cmd = { "rustup", "run", "nightly", "rust-analyzer" },
    },
    tsserver = {
        before_init = function(params)
            params.processId = vim.NIL
        end,
    },
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
