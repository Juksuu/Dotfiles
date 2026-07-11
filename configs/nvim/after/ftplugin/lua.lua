if not vim.g.lazydev_loaded then
    vim.g.lazydev_loaded = true
    require("lazydev").setup({
        library = {
            -- See the configuration section for more details
            -- Load luvit types when the `vim.uv` word is found
            { path = "${3rd}/luv/library", words = { "vim%.uv" } },

            -- Load snacks.nvim types when the `Snacks` word is found
            { path = "snacks.nvim", words = { "Snacks" } },
        },
    })
end
