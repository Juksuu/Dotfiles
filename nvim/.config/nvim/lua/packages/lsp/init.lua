local fidget_conf = function()
    require("fidget").setup({
        window = {
            relative = "editor",
            blend = 0,
        },
    })
end

local codeaction_conf = function()
    vim.keymap.set("n", "<leader>la", "<cmd> CodeActionMenu <CR>")
end

local mason_conf = function()
    require("mason").setup()
end

local null_ls_conf = function()
    local null = require("null-ls")
    null.setup({
        sources = {
            null.builtins.formatting.stylua,
            null.builtins.formatting.prettier,
            null.builtins.formatting.rustfmt,
            null.builtins.formatting.black,

            null.builtins.code_actions.eslint_d,

            null.builtins.diagnostics.eslint_d,
        },
    })

    require("mason-null-ls").setup({
        automatic_installation = true,
    })

    -- Configure commands for enabling and disabling run on save
    vim.g.format_on_save = true

    vim.api.nvim_create_user_command("FormatOnSaveDisable", function()
        vim.g.format_on_save = false
    end, {})

    vim.api.nvim_create_user_command("FormatOnSaveEnable", function()
        vim.g.format_on_save = true
    end, {})

    local group = vim.api.nvim_create_augroup("AutoFormat", { clear = true })
    vim.api.nvim_create_autocmd("BufWritePre", {
        callback = function()
            if vim.g.format_on_save then
                vim.lsp.buf.format()
            end
        end,
        group = group,
    })
end

local lsp_conf = function()
    local server_config = require("packages.lsp.server_configuration")
    local mason = require("mason-lspconfig")

    mason.setup({
        ensure_installed = server_config.servers,
    })

    local nvim_lsp = require("lspconfig")

    -- Disable gutter signs, color linenum instead
    local sign = function(name)
        vim.fn.sign_define(name, { text = "", numhl = name })
    end
    sign("DiagnosticSignWarn")
    sign("DiagnosticSignInfo")
    sign("DiagnosticSignHint")
    sign("DiagnosticSignError")

    local capabilities = require("cmp_nvim_lsp").default_capabilities()

    local custom_attach = function(client, bufnr)
        local bufopts = { noremap = true, silent = true, buffer = bufnr }
        vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
        vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, bufopts)
        vim.keymap.set("n", "]d", vim.diagnostic.goto_next, bufopts)
        vim.keymap.set("n", "dl", vim.diagnostic.open_float, bufopts)
        vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, bufopts)
        vim.keymap.set({ "n", "v" }, "<leader>lf", vim.lsp.buf.format, bufopts)
        vim.keymap.set({ "n", "i" }, "<c-k>", vim.lsp.buf.signature_help, bufopts)

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

    local setup_server = function(server, opts)
        opts.capabilities = capabilities
        opts.on_attach = custom_attach

        nvim_lsp[server].setup(opts)
    end

    mason.setup_handlers({
        function(server)
            local server_opts = server_config.server_settings[server] or {}
            setup_server(server, server_opts)
        end,
    })
end

return {
    {
        "williamboman/mason.nvim",
        config = mason_conf,
    },

    {
        "williamboman/mason-lspconfig.nvim",
        requires = "neovim/nvim-lspconfig",
        after = "mason.nvim",
        config = lsp_conf,
    },

    {
        "jayp0521/mason-null-ls.nvim",
        requires = "jose-elias-alvarez/null-ls.nvim",
        after = "mason.nvim",
        config = null_ls_conf,
    },

    {
        "j-hui/fidget.nvim",
        after = "mason-lspconfig.nvim",
        config = fidget_conf,
    },

    {
        "weilbith/nvim-code-action-menu",
        after = "mason-lspconfig.nvim",
        config = codeaction_conf,
    },
}
