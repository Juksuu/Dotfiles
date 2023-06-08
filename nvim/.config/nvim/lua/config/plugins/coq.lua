local M = {
    "ms-jpq/coq_nvim",
    branch = "coq",
    event = { "BufReadPre" },
    dependencies = {
        { "ms-jpq/coq.artifacts", branch = "artifacts" },
    },
}

function M.config()
    require("coq")
end

function M.init()
    vim.g.coq_settings = {
        auto_start = "shut-up",
        clients = {
            tabnine = {
                enabled = true,
            },
        },
    }
end

return M
