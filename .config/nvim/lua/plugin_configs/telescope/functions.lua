local M = {}

-- LuaFormatter off

--- SEARCH ---
function M.find_files()
    require('telescope.builtin').find_files()
end

function M.grep_string()
    require('telescope.builtin').grep_string {
        shorten_path = true
    }
end

function M.live_grep()
    require('telescope.builtin').live_grep {
        shorten_path = true
    }
end

--- GIT ---
function M.git_files()
    local opts = require('telescope.themes').get_ivy {
        --[[ previewer = false,
        shorten_path = false ]]
    }

    require('telescope.builtin').git_files(opts)
end

function M.git_worktrees()
    require('telescope').extensions.git_worktree.git_worktrees()
end

function M.create_git_worktree()
    require('telescope').extensions.git_worktree.create_git_worktree()
end

function M.git_stash()
    require('telescope.builtin').git_stash()
end

--- LSP ---
function M.lsp_references()
    require('telescope.builtin').lsp_references()
end

function M.lsp_code_actions()
    require('telescope.builtin').lsp_code_actions()
end

function M.lsp_definitions()
    require('telescope.builtin').lsp_definitions()
end

function M.lsp_document_diagnostics()
    require('telescope.builtin').lsp_document_diagnostics()
end

function M.lsp_workspace_diagnostics()
    require('telescope.builtin').lsp_workspace_diagnostics()
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
