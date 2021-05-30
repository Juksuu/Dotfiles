local M = {}

-- LuaFormatter off
local function ivy(opts)
    return require('telescope.themes').get_ivy(opts)
end

--- SEARCH ---
function M.find_files()
    local opts = {}
    require('telescope.builtin').find_files(ivy(opts))
end

function M.grep_string()
    local opts = {
        shorten_path = true
    }
    require('telescope.builtin').grep_string(ivy(opts))
end

function M.live_grep()
    local opts = {
        shorten_path = true
    }
    require('telescope.builtin').live_grep(ivy(opts))
end

--- GIT ---
function M.git_files()
    local opts = {
        shorten_path = false
    }
    require('telescope.builtin').git_files(ivy(opts))
end

function M.git_worktrees()
    require('telescope').extensions.git_worktree.git_worktrees()
end

function M.create_git_worktree()
    require('telescope').extensions.git_worktree.create_git_worktree()
end

function M.git_stash()
    local opts = {}
    require('telescope.builtin').git_stash(ivy(opts))
end

--- LSP ---
function M.lsp_references()
    local opts = {}
    require('telescope.builtin').lsp_references(ivy(opts))
end

function M.lsp_code_actions()
    local opts = {}
    require('telescope.builtin').lsp_code_actions(ivy(opts))
end

function M.lsp_definitions()
    local opts = {}
    require('telescope.builtin').lsp_definitions(ivy(opts))
end

function M.lsp_document_diagnostics()
    local opts = {}
    require('telescope.builtin').lsp_document_diagnostics(ivy(opts))
end

function M.lsp_workspace_diagnostics()
    local opts = {}
    require('telescope.builtin').lsp_workspace_diagnostics(ivy(opts))
end

return setmetatable({}, {
    __index = function(_, k)
        if M[k] then
            return M[k]
        else
            return require('telescope.builtin')[k]
        end
    end
})
-- LuaFormatter on
