local config = {}

function config.git_worktree()
    require("git-worktree").setup()
end

return config
