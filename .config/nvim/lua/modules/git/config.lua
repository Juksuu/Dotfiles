local config = {}

-- LuaFormatter off
function config.git_worktree()
    require("git-worktree").setup()
end
-- LuaFormatter on

return config
