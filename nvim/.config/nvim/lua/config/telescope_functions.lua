local M = {}

--- FILE BROWSER ---
function M.file_browser()
    require("telescope").extensions.file_browser.file_browser()
end

--- SEARCH ---
function M.find_files()
    local opts = {
        hidden = true,
        file_ignore_patterns = { "**.min" },
    }
    require("telescope.builtin").find_files(opts)
end

function M.live_grep()
    local opts = {
        path_display = {
            "shorten",
        },
        file_ignore_patterns = { "**.min" },
    }
    require("telescope.builtin").live_grep(opts)
end

--- GIT ---
function M.git_files()
    local opts = {
        hidden = true,
        previewer = false,
    }
    require("telescope.builtin").git_files(opts)
end

function M.worktrees()
    local opts = {
        path_display = {
            "smart",
        },
    }
    require("telescope").extensions.worktrees.list_worktrees(opts)
end

--- LSP ---
function M.diagnostics()
    local opts = {
        bufnr = 0,
    }
    require("telescope.builtin").diagnostics(opts)
end

function M.workspace_diagnostics()
    local opts = {}
    require("telescope.builtin").diagnostics(opts)
end

return setmetatable({}, {
    __index = function(_, k)
        if M[k] then
            return M[k]
        else
            return require("telescope.builtin")[k]
        end
    end,
})
