local M = {}

-- LuaFormatter off
--- THEMES ---
local function ivy(opts)
    return require('telescope.themes').get_ivy(opts)
end
local function dropdown(opts)
    return require('telescope.themes').get_dropdown(opts)
end

--- SEARCH ---
function M.find_files()
    local opts = {
        hidden = true,
        file_ignore_patterns = {"**.min"},
    }
    require('telescope.builtin').find_files(opts)
end

function M.grep_string()
    local opts = {
        path_display = {
            'shorten'
        },
        file_ignore_patterns = {"**.min"},
    }
    require('telescope.builtin').grep_string(ivy(opts))
end

function M.live_grep()
    local opts = {
        path_display = {
            'shorten'
        },
        file_ignore_patterns = {"**.min"},
    }
    require('telescope.builtin').live_grep(ivy(opts))
end

--- GIT ---
function M.git_files()
    local opts = {
        hidden = true,
        previewer = false,
    }
    require('telescope.builtin').git_files(dropdown(opts))
end

function M.git_worktrees()
    require('telescope').extensions.git_worktree.git_worktrees()
end

function M.create_git_worktree()
    require('telescope').extensions.git_worktree.create_git_worktree()
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
