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
    vim.g.tokyonight_colors = { hint = "teal", error = "#ff0000" }

    vim.cmd[[ colorscheme tokyonight ]]
end

function config.colorizer()
    require('colorizer').setup()
end

function config.lualine()
    require('lualine').setup {
        options = { 
            theme = 'tokyonight',
        },
        sections = {
            lualine_a = {'mode'},
            lualine_b = {'branch'},
            lualine_c = {{'diagnostics', sources = { 'nvim_lsp' }}},
            lualine_d = {'filename'},
            lualine_x = {'encoding', 'fileformat', 'filetype'},
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
