return function()
    require("luasnip").config.set_config({
        history = true,
    })
    require("luasnip/loaders/from_vscode").lazy_load({
        paths = {
            "~/.local/share/nvim/site/pack/packer/start/friendly-snippets",
        },
    })

    vim.keymap.set({ "n", "s", "i" }, "<C-h>", function()
        require("luasnip").jump(-1)
    end)
    vim.keymap.set({ "n", "s", "i" }, "<C-l>", function()
        require("luasnip").jump(1)
    end)
end
