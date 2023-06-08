local M = {
    "ms-jpq/coq_nvim",
    branch = "coq",
    event = { "BufReadPost" },
    dependencies = {
        { "ms-jpq/coq.artifacts", branch = "artifacts" },
        {
            "ms-jpq/coq.thirdparty",
            branch = "3p",
            config = function()
                require("coq_3p")({
                    { src = "nvimlua", short_name = "nLUA" },
                })
            end,
        },
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
