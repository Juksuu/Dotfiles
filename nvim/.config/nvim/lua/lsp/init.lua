return function()
    local nvim_lsp = require("lspconfig")
    local server_config = require("lsp.server_configuration")

    -- Disable gutter signs, color linenum instead
    vim.fn.sign_define(
        "DiagnosticSignError",
        { text = "", numhl = "DiagnosticSignError" }
    )
    vim.fn.sign_define("DiagnosticSignWarn", { text = "", numhl = "DiagnosticSignWarn" })
    vim.fn.sign_define("DiagnosticSignInfo", { text = "", numhl = "DiagnosticSignInfo" })
    vim.fn.sign_define("DiagnosticSignHint", { text = "", numhl = "DiagnosticSignHint" })

    local capabilities = require("cmp_nvim_lsp").update_capabilities(
        vim.lsp.protocol.make_client_capabilities()
    )

    local custom_attach = function(client, bufnr)
        local bufopts = { noremap = true, silent = true, buffer = bufnr }
        vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
        vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts)
        vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, bufopts)
        vim.keymap.set("n", "]d", vim.diagnostic.goto_next, bufopts)
        vim.keymap.set("n", "dl", vim.diagnostic.open_float, bufopts)
        vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, bufopts)
        vim.keymap.set("n", "<c-k>", vim.lsp.buf.signature_help, bufopts)
        vim.keymap.set("i", "<c-k>", vim.lsp.buf.signature_help, bufopts)

        if client.server_capabilities.code_lens then
            vim.cmd([[
              augroup lsp_document_codelens
                au! * <buffer>
                autocmd BufEnter ++once <buffer> lua require("vim.lsp.codelens").refresh()
                autocmd BufWritePost,CursorHold <buffer> lua require("vim.lsp.codelens").refresh()
              augroup END
            ]])
        end
    end

    for _, lsp in ipairs(server_config.servers) do
        local opts = {
            capabilities = capabilities,
            on_attach = custom_attach,
        }
        local server_opts = server_config.custom_server_settings[lsp.server] or {}
        opts = vim.tbl_deep_extend("force", opts, server_opts)

        if lsp.docker then
            local docker_settings = server_config.custom_docker_settings[lsp.server] or {}

            opts["cmd"] = require("lspcontainers").command(lsp.server, docker_settings)
        end
        nvim_lsp[lsp.server].setup(opts)
    end
end
