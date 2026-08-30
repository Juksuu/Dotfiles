local M = {}

local function colorscheme_available(name)
    return #vim.api.nvim_get_runtime_file("colors/" .. name .. ".vim", true) > 0
        or #vim.api.nvim_get_runtime_file("colors/" .. name .. ".lua", true)
            > 0
end

local lualine_theme = nil

function M.initColors()
    if colorscheme_available("dms") then
        require("plugins.base46")
        lualine_theme = "dms"
    else
        require("plugins.catppuccin")
        lualine_theme = "catppuccin-nvim"
    end
end

function M.getLualineTheme()
    if lualine_theme ~= nil then
        return lualine_theme
    end

    print("initColors() needs to be called first")
    return nil
end

return M
