local config = {}

function config.gruvbuddy()
    require('colorbuddy').colorscheme('gruvbuddy')
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
