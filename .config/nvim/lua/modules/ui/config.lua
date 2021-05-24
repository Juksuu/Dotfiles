local config = {}

function config.gitsigns()
    require('gitsigns').setup()
end

function config.colorizer()
    require('colorizer').setup()
end

function config.tokyonight()
    vim.g.tokyonight_style = "storm"
    vim.g.tokyonight_transparent = true
    vim.g.tokyonight_italic_functions = true

    -- Change the "hint" color to the "orange" color, and make the "error" color bright red
    vim.g.tokyonight_colors = { hint = "teal", error = "#ff0000" }

    vim.cmd[[ colorscheme tokyonight ]]
end

function config.vibrantgrey()
    vim.g.vibrantgrey_transparent = true
    vim.g.vibrantgrey_italic_comments= true
	require("colorbuddy").colorscheme("vibrantgrey")
end

function config.lualine()
    require('lualine').setup {
        sections = {
            lualine_a = {'mode'},
            lualine_b = {'branch', 'filename'},
            lualine_c = {{'diagnostics', sources = { 'nvim_lsp' }}},
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
