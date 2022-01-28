return function()
    require("lsp_lines").register_lsp_virtual_lines()

    vim.g.diagnostic_virtual_text = false
    vim.g.diagnostic_virtual_lines = true

    vim.diagnostic.config({
        virtual_text = vim.g.diagnostic_virtual_text,
        virtual_lines = vim.g.diagnostic_virtual_lines,
    })

    vim.api.nvim_add_user_command("DiagnosticCycleStyle", function()
        if vim.g.diagnostic_virtual_lines then
            vim.g.diagnostic_virtual_text = true
            vim.g.diagnostic_virtual_lines = false
        elseif vim.g.diagnostic_virtual_text then
            vim.g.diagnostic_virtual_text = false
            vim.g.diagnostic_virtual_lines = false
        else
            vim.g.diagnostic_virtual_text = false
            vim.g.diagnostic_virtual_lines = true
        end

        vim.diagnostic.config({
            virtual_text = vim.g.diagnostic_virtual_text,
            virtual_lines = vim.g.diagnostic_virtual_lines,
        })
    end, {})

    vim.keymap.set("n", "<leader>ds", "<cmd> DiagnosticCycleStyle <CR>")
end
