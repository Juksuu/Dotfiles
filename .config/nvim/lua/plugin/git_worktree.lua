local git_worktree = require("git-worktree")
git_worktree.setup()

local M = {}
local nnoremap = vim.keymap.nnoremap

function M.create_worktree()
    local name = vim.fn.input("Name:")
    local upstream = vim.fn.input("Upstream:")

    git_worktree.create_worktree(name, upstream)
end

nnoremap { '<leader>gn', M.create_worktree}
nnoremap { '<leader>gw', require('telescope').extensions.git_worktree.git_worktrees}
