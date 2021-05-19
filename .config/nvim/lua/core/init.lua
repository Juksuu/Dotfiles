local utils = require('core.utils')
local vim = vim

-- Create cache dir and subs dir
local createdir = function ()
    local data_dir = {
        utils.cache_dir..'session',
        utils.cache_dir..'undo'
    }
    -- There only check once that If cache_dir exists
    -- Then I don't want to check subs dir exists
    if vim.fn.isdirectory(utils.cache_dir) == 0 then
        os.execute("mkdir -p " .. utils.cache_dir)
        for _,v in pairs(data_dir) do
            if vim.fn.isdirectory(v) == 0 then
                os.execute("mkdir -p " .. v)
            end
        end
    end
end

local disable_distribution_plugins= function()
    vim.g.loaded_gzip              = 1
    vim.g.loaded_tar               = 1
    vim.g.loaded_tarPlugin         = 1
    vim.g.loaded_zip               = 1
    vim.g.loaded_zipPlugin         = 1
    vim.g.loaded_getscript         = 1
    vim.g.loaded_getscriptPlugin   = 1
    vim.g.loaded_vimball           = 1
    vim.g.loaded_vimballPlugin     = 1
    vim.g.loaded_matchit           = 1
    vim.g.loaded_matchparen        = 1
    vim.g.loaded_2html_plugin      = 1
    vim.g.loaded_logiPat           = 1
    vim.g.loaded_rrhelper          = 1
end

local leader_map = function()
    vim.g.mapleader = " "
    vim.api.nvim_set_keymap('n',' ','',{noremap = true})
    vim.api.nvim_set_keymap('x',' ','',{noremap = true})
end

local load_core = function()
    local pack = require('core.pack')
    createdir()
    disable_distribution_plugins()
    leader_map()

    pack.ensure_plugins()
    require('core.globals')
    require('core.options')
    require('keymaps')
    require('core.autocommands')
    pack.load_compile()
end

load_core()