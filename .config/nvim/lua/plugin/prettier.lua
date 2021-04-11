local u = require('juksu.utils')

u.create_augroup('PrettierAuto',{
    'BufWritePre *.css,*.svelte,*.pcss,*.html,*.ts,*.js,*.json,*.yml,*.yaml PrettierAsync'
})
