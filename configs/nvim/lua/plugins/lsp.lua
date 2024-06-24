local methods = vim.lsp.protocol.Methods

local M = {
    "neovim/nvim-lspconfig",
    event = "BufReadPre",
    dependencies = {
        { "folke/neoconf.nvim", config = true },
    },
}

local custom_attach = function(client, bufnr)
    ---Utility for keymap creation.
    ---@param lhs string
    ---@param rhs string|function
    ---@param opts string|table
    ---@param mode? string|string[]
    local function keymap(lhs, rhs, opts, mode)
        opts = type(opts) == "string" and { desc = opts }
            or vim.tbl_extend("error", opts --[[@as table]], { buffer = bufnr })
        mode = mode or "n"
        vim.keymap.set(mode, lhs, rhs, opts)
    end

    ---For replacing certain <C-x>... keymaps.
    ---@param keys string
    local function feedkeys(keys)
        vim.api.nvim_feedkeys(
            vim.api.nvim_replace_termcodes(keys, true, false, true),
            "n",
            true
        )
    end

    ---Is the completion menu open?
    local function pumvisible()
        return tonumber(vim.fn.pumvisible()) ~= 0
    end

    client.server_capabilities.semanticTokensProvider = false

    local toggle_inlay_hints = function()
        if client.supports_method("textDocument/inlayHint") then
            local ih = vim.lsp.buf.inlay_hint or vim.lsp.inlay_hint
            local value = not ih.is_enabled({ bufnr })
            ih.enable(value, { bufnr })
        end
    end

    local toggle_diagnostics = function()
        if vim.diagnostic.is_enabled(bufnr) then
            vim.diagnostic.enable(false, { bufnr })
        else
            vim.diagnostic.enable(true, { bufnr })
        end
    end

    keymap("gd", vim.lsp.buf.definition, {})
    keymap("dl", vim.diagnostic.open_float, {})

    keymap("<leader>td", toggle_diagnostics, {})
    keymap("<leader>ti", toggle_inlay_hints, {})

    if client.supports_method(methods.textDocument_completion) then
        vim.lsp.completion.enable(
            true,
            client.id,
            bufnr,
            { autotrigger = true }
        )

        -- Use slash to dismiss the completion menu.
        keymap("/", function()
            return pumvisible() and "<C-e>" or "/"
        end, { expr = true }, "i")

        -- Use <C-n> to navigate to the next completion or:
        -- - Trigger LSP completion.
        -- - If there's no one, fallback to vanilla omnifunc.
        keymap("<c-n>", function()
            if pumvisible() then
                feedkeys("<C-n>")
            else
                if next(vim.lsp.get_clients({ bufnr = 0 })) then
                    vim.lsp.completion.trigger()
                else
                    if vim.bo.omnifunc == "" then
                        feedkeys("<C-x><C-n>")
                    else
                        feedkeys("<C-x><C-o>")
                    end
                end
            end
        end, {}, "i")

        -- Use <Tab> to navigate between snippet tabstops,
        keymap("<Tab>", function()
            if vim.snippet.active({ direction = 1 }) then
                vim.snippet.jump(1)
            else
                feedkeys("<Tab>")
            end
        end, {}, { "i", "s" })
        keymap("<S-Tab>", function()
            if vim.snippet.active({ direction = -1 }) then
                vim.snippet.jump(-1)
            else
                feedkeys("<S-Tab>")
            end
        end, {}, { "i", "s" })

        -- Inside a snippet, use backspace to remove the placeholder.
        keymap("<BS>", "<C-o>s", {}, "s")
    end
end

function M.config()
    vim.diagnostic.config({
        underline = true,
        update_in_insert = false,
        severity_sort = true,
        signs = {
            text = {
                [vim.diagnostic.severity.HINT] = "",
                [vim.diagnostic.severity.INFO] = "",
                [vim.diagnostic.severity.WARN] = "",
                [vim.diagnostic.severity.ERROR] = "",
            },
            numhl = {
                [vim.diagnostic.severity.HINT] = "DiagnosticSignHint",
                [vim.diagnostic.severity.INFO] = "DiagnosticSignInfo",
                [vim.diagnostic.severity.WARN] = "DiagnosticSignWarn",
                [vim.diagnostic.severity.ERROR] = "DiagnosticSignError",
            },
        },
    })

    vim.lsp.handlers["textDocument/hover"] =
        vim.lsp.with(vim.lsp.handlers.hover, {
            border = "rounded",
        })

    vim.lsp.handlers["textDocument/signatureHelp"] =
        vim.lsp.with(vim.lsp.handlers.signature_help, {
            border = "rounded",
        })

    local nvim_lsp = require("lspconfig")
    local neoconf_lsp_config = require("neoconf").get("lspconfig")

    for server, config in pairs(neoconf_lsp_config) do
        local opts = {
            on_attach = custom_attach,
            capabilities = vim.lsp.protocol.make_client_capabilities(),
        }
        local cmd = config["cmd"]
        if type(cmd) == "table" then
            opts.cmd = cmd
        end

        nvim_lsp[server].setup(opts)
    end
end

return M
