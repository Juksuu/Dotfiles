local config = {}

function config.telescope()
    require('modules.utils.telescope')
end

function config.editorconfig()
    vim.g.EditorConfig_exclude_patterns = {'fugitive://.*', 'scp://.*'}
end

function config.plenary()
    RELOAD = require('plenary.reload').reload_module

    R = function(name)
        RELOAD(name)
        return require(name)
    end
end

function config.nvimtree()
    vim.g.nvim_tree_follow = 1
    vim.g.nvim_tree_hide_dotfiles = 1
    vim.g.nvim_tree_indent_markers = 1
    vim.g.nvim_tree_disable_netrw = 0
    vim.g.nvim_tree_hijack_netrw = 0
end

function config.surround()
    vim.g.surround_context_offset = 50
    require('surround').setup {}
end

function config.lsp_trouble()
    require('trouble').setup {
        signs = {
            -- icons / text used for a diagnostic
            error = "",
            warning = "",
            hint = "",
            information = ""
        },
    }
end

return config
