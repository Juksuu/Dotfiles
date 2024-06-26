local M = {
    "mfussenegger/nvim-lint",
    event = { "BufReadPre", "BufNewFile" },
}

function M.config()
    local lint = require("lint")

    local linters_by_ft = {}

    local neoconf_linters = require("neoconf").get("linters")

    if type(neoconf_linters) == "table" then
        for ft, linter in pairs(neoconf_linters) do
            linters_by_ft[ft] = linter
        end
    end

    lint.linters_by_ft = linters_by_ft

    local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

    vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
        group = lint_augroup,
        callback = function()
            lint.try_lint()
        end,
    })
end

return M
