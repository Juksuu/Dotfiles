vim.api.nvim_create_autocmd("PackChanged", {
    callback = function(ev)
        local name, kind = ev.data.spec.name, ev.data.kind

        if name == "blink.cmp" and (kind == "install" or kind == "update") then
            if not ev.data.active then
                vim.cmd.packadd("blink.lib")
                vim.cmd.packadd("blink.cmp")
            end
            vim.system({ "nix", "build", "." }, { cwd = ev.data.path }):wait()
            vim.system({ "rm", "-rf", "lib" }, { cwd = ev.data.path }):wait()
            vim.system({ "mkdir", "-p", "lib" }, { cwd = ev.data.path }):wait()
            vim.system(
                { "cp", "result/lib/libblink_cmp_fuzzy.so", "lib/" },
                { cwd = ev.data.path }
            ):wait()
        end

        if
            name == "nvim-treesitter"
            and (kind == "install" or kind == "update")
        then
            if not ev.data.active then
                vim.cmd.packadd("nvim-treesitter")
            end
            vim.cmd("TSUpdate")
        end
    end,
})

vim.pack.add({
    "https://github.com/nvim-lua/plenary.nvim",
    "https://github.com/nvim-tree/nvim-web-devicons",
    "https://github.com/nvim-treesitter/nvim-treesitter",
    "https://github.com/nvim-lualine/lualine.nvim",
    "https://github.com/folke/lazydev.nvim",
    "https://github.com/direnv/direnv.vim",
    "https://github.com/tpope/vim-sleuth",
    "https://github.com/aserowy/tmux.nvim",
    "https://github.com/nvim-mini/mini.pairs",
    "https://github.com/lewis6991/gitsigns.nvim",
    "https://github.com/j-hui/fidget.nvim",
    "https://github.com/stevearc/conform.nvim",
    "https://github.com/rebelot/heirline.nvim",
    "https://github.com/mfussenegger/nvim-lint",
    "https://github.com/neovim/nvim-lspconfig",
    "https://github.com/hrsh7th/nvim-pasta",
    "https://github.com/folke/snacks.nvim",
    "https://github.com/NeogitOrg/neogit",
    "https://github.com/sindrets/diffview.nvim",
    "https://github.com/rafamadriz/friendly-snippets",
    "https://github.com/mfussenegger/nvim-dap",
    "https://github.com/rcarriga/nvim-dap-ui",
    "https://github.com/nvim-neotest/nvim-nio",
    "https://github.com/ldelossa/nvim-dap-projects",
    "https://github.com/folke/trouble.nvim",
    "https://github.com/folke/todo-comments.nvim",
    "https://github.com/MeanderingProgrammer/render-markdown.nvim",
    "https://github.com/saghen/blink.cmp",
    "https://github.com/saghen/blink.lib",
    "https://github.com/Bekaboo/dropbar.nvim",

    -- stylua: ignore start
    { src = "https://github.com/catppuccin/nvim",               name = "catppuccin" },
    { src = "https://github.com/Juksuu/worktrees.nvim",         name = "worktrees" },
    { src = "https://github.com/mikavilpas/blink-ripgrep.nvim", version = vim.version.range("2") },
    -- stylua: ignore end
})

-- Local project paths
-- vim.opt.rtp:append("~/code/worktrees.nvim/main")

vim.cmd.packadd("nvim.undotree")

require("gitsigns").setup()
require("fidget").setup({})
require("mini.pairs").setup()

require("neogit").setup({ disable_commit_confirmation = true })
require("tmux").setup({
    copy_sync = {
        enable = false,
    },
})
require("render-markdown").setup({
    anti_conceal = { enabled = false },
    file_types = { "markdown" },
})

vim.keymap.set("n", "<leader>gs", "<cmd>Neogit<CR>")

-- Load plugin files
require("plugins.catppuccin")
require("plugins.treesitter")
require("plugins.lsp")
-- require("plugins.heirline")
require("plugins.lualine")
require("plugins.blink-cmp")
require("plugins.conform")
require("plugins.lint")
require("plugins.dap")
require("plugins.nvim-pasta")
require("plugins.snacks")
require("plugins.trouble")

-- Load worktrees plugin last as it has extra functionality if other plugins are loaded
require("worktrees").setup({})
