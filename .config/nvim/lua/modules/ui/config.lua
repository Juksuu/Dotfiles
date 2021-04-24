local config = {}

function config.gruvbuddy()
    require('colorbuddy').colorscheme('gruvbuddy')
end

function config.tokyonight()
    vim.g.tokyonight_style = "storm"
    vim.g.tokyonight_transparent = true
    vim.g.tokyonight_italic_functions = true
    -- vim.g.tokyonight_sidebars = { "qf", "vista_kind", "terminal", "packer" }

    -- Change the "hint" color to the "orange" color, and make the "error" color bright red
    vim.g.tokyonight_colors = { hint = "orange", error = "#ff0000" }

    vim.cmd[[ colorscheme tokyonight ]]
end

function config.colorizer()
    require('colorizer').setup()
end

function config.lualine()
    local function lsp_status()
        if #vim.lsp.buf_get_clients() > 0 then
            return require('lsp-status').status()
        end
    end

    require('lualine').setup {
        options = { 
            theme = 'everforest',
            section_separators = '',
            component_separators = ''
        },
        sections = {
            lualine_a = {'mode'},
            lualine_b = {'branch'},
            lualine_c = {'filename'},
            lualine_x = {'encoding', 'fileformat', 'filetype'},
            lualine_y = {lsp_status},
            lualine_z = {'location'}
        },
        inactive_sections = {
            lualine_a = {},
            lualine_b = {},
            lualine_c = {'filename'},
            lualine_x = {'location'},
            lualine_y = {},
            lualine_z = {}
        }
    }
end

return config
