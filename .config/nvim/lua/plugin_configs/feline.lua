-- LuaFormatter off
return function() 
    local lsp = require('feline.providers.lsp')
    local vi_mode_utils = require('feline.providers.vi_mode')

    local properties = {
        force_inactive = {
            filetypes = {},
            buftypes = {},
            bufnames = {}
        }
    }

    local components = {
        active = {},
        inactive = {}
    }

    local colors = {
        bg = '#282828',
        black = '#282828',
        yellow = '#d8a657',
        cyan = '#89b482',
        oceanblue = '#45707a',
        green = '#a9b665',
        orange = '#e78a4e',
        violet = '#d3869b',
        magenta = '#c14a4a',
        white = '#a89984',
        fg = '#a89984',
        skyblue = '#7daea3',
        red = '#ea6962',
    }

    local vi_mode_colors = {
        NORMAL = 'green',
        OP = 'green',
        INSERT = 'red',
        VISUAL = 'skyblue',
        BLOCK = 'skyblue',
        REPLACE = 'violet',
        ['V-REPLACE'] = 'violet',
        ENTER = 'cyan',
        MORE = 'cyan',
        SELECT = 'orange',
        COMMAND = 'green',
        SHELL = 'green',
        TERM = 'green',
        NONE = 'yellow'
    }

    local vi_mode_text = {
        NORMAL = '<|',
        OP = '<|',
        INSERT = '|>',
        VISUAL = '<>',
        BLOCK = '<>',
        REPLACE = '<>',
        ['V-REPLACE'] = '<>',
        ENTER = '<>',
        MORE = '<>',
        SELECT = '<>',
        COMMAND = '<|',
        SHELL = '<|',
        TERM = '<|',
        NONE = '<>'
    }

    local buffer_not_empty = function()
        if vim.fn.empty(vim.fn.expand('%:t')) ~= 1 then
            return true
        end
        return false
    end

    local checkwidth = function()
        local squeeze_width  = vim.fn.winwidth(0) / 2
        if squeeze_width > 40 then
            return true
        end
        return false
    end

    properties.force_inactive.filetypes = {
        'NvimTree',
        'dbui',
        'packer',
        'startify',
        'fugitive',
        'fugitiveblame'
    }

    properties.force_inactive.buftypes = {
        'terminal'
    }

    -- LEFT
    table.insert(components.active, {})

    -- vi-mode
    table.insert(components.active[1], {
        provider = ' NV-IDE ',
        hl = function()
            local val = {}

            val.bg = vi_mode_utils.get_mode_color()
            val.fg = 'black'
            val.style = 'bold'

            return val
        end,
        right_sep = ' '
    })

    -- vi-symbol
    table.insert(components.active[1], {
        provider = function()
            return vi_mode_text[vi_mode_utils.get_vim_mode()]
        end,
        hl = function()
            local val = {}
            val.fg = vi_mode_utils.get_mode_color()
            val.bg = 'bg'
            val.style = 'bold'
            return val
        end,
        right_sep = ' '
    })

    -- filename
    table.insert(components.active[1], {
        provider = function()
            return vim.fn.expand("%:t")
        end,
        hl = {
            fg = 'white',
            bg = 'bg',
            style = 'bold'
        },
        right_sep = ' '
    })

    -- gitBranch
    table.insert(components.active[1], {
        provider = 'git_branch',
        hl = {
            fg = 'yellow',
            bg = 'bg',
            style = 'bold'
        }
    })

    -- diffAdd
    table.insert(components.active[1], {
        provider = 'git_diff_added',
        hl = {
            fg = 'green',
            bg = 'bg',
            style = 'bold'
        }
    })

    -- diffModfified
    table.insert(components.active[1], {
        provider = 'git_diff_changed',
        hl = {
            fg = 'orange',
            bg = 'bg',
            style = 'bold'
        }
    })

    -- diffRemove
    table.insert(components.active[1], {
        provider = 'git_diff_removed',
        hl = {
            fg = 'red',
            bg = 'bg',
            style = 'bold'
        }
    })

    -- MID
    table.insert(components.active, {})

    -- LspName
    table.insert(components.active[2], {
        provider = 'lsp_client_names',
        hl = {
            fg = 'yellow',
            bg = 'bg',
            style = 'bold'
        },
        right_sep = ' '
    })

    -- diagnosticErrors
    table.insert(components.active[2], {
        provider = 'diagnostic_errors',
        enabled = function() return lsp.diagnostics_exist('Error') end,
        hl = {
            fg = 'red',
            style = 'bold'
        }
    })

    -- diagnosticWarn
    table.insert(components.active[2], {
        provider = 'diagnostic_warnings',
        enabled = function() return lsp.diagnostics_exist('Warning') end,
        hl = {
            fg = 'yellow',
            style = 'bold'
        }
    })

    -- diagnosticHint
    table.insert(components.active[2], {
        provider = 'diagnostic_hints',
        enabled = function() return lsp.diagnostics_exist('Hint') end,
        hl = {
            fg = 'cyan',
            style = 'bold'
        }
    })

    -- diagnosticInfo
    table.insert(components.active[2], {
        provider = 'diagnostic_info',
        enabled = function() return lsp.diagnostics_exist('Information') end,
        hl = {
            fg = 'skyblue',
            style = 'bold'
        }
    })

    -- RIGHT
    table.insert(components.active, {})

    -- fileSize
    table.insert(components.active[3], {
        provider = 'file_size',
        enabled = function() return vim.fn.getfsize(vim.fn.expand('%:t')) > 0 end,
        hl = {
            fg = 'skyblue',
            bg = 'bg',
            style = 'bold'
        },
        right_sep = ' '
    })

    -- fileFormat
    table.insert(components.active[3], {
        provider = function() return '' .. vim.bo.fileformat:upper() .. '' end,
        hl = {
            fg = 'white',
            bg = 'bg',
            style = 'bold'
        },
        right_sep = ' '
    })

    -- fileEncode
    table.insert(components.active[3], {
        provider = 'file_encoding',
        hl = {
            fg = 'white',
            bg = 'bg',
            style = 'bold'
        },
        right_sep = ' '
    })

    -- lineInfo
    table.insert(components.active[3], {
        provider = 'position',
        hl = {
            fg = 'white',
            bg = 'bg',
            style = 'bold'
        },
        right_sep = ' '
    })

    -- INACTIVE
    table.insert(components.inactive, {})

    -- fileType
    table.insert(components.inactive[1], {
        provider = 'file_type',
        hl = {
            fg = 'black',
            bg = 'cyan',
            style = 'bold'
        },
        left_sep = {
            str = ' ',
            hl = {
                fg = 'NONE',
                bg = 'cyan'
            }
        },
        right_sep = {
            {
                str = ' ',
                hl = {
                    fg = 'NONE',
                    bg = 'cyan'
                }
            },
            ' '
        }
    })

    require('feline').setup({
            colors = colors,
            default_bg = bg,
            default_fg = fg,
            vi_mode_colors = vi_mode_colors,
            components = components,
            properties = properties,
        })
end
-- LuaFormatter on
