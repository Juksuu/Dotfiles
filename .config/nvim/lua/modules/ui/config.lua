local config = {}

function config.gruvbuddy()
    require('colorbuddy').colorscheme('gruvbuddy')
end

function config.colorizer()
    require('colorizer').setup()
end

function config.cyclist()
    -- vim.cmd [[ set list ]]

    --     call cyclist#add_listchar_option_set('limited', {
    --         \ 'eol': '?',
    --         \ 'tab': 'È ',
    --         \ 'trail': 'á',
    --         \ 'extends': '<',
    --         \ 'precedes': '>',    
    --         \ 'conceal': '?',
    --         \ 'nbsp': '?',
    --         \ })

    --     call cyclist#add_listchar_option_set('busy', {
    --         \ 'eol': '?',
    --         \ 'tab': 'Èá',
    --         \ 'space': '?',
    --         \ 'trail': '-',
    --         \ 'extends': '?',
    --         \ 'precedes': '?',    
    --         \ 'conceal': '?',
    --         \ 'nbsp': '?',
    --         \ })
    -- ]]
end

return config
