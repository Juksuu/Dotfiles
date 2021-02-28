nmap <Leader>p <Plug>(Prettier)
let g:prettier#autoformat_require_pragma = 0
let g:prettier#autoformat_config_present = 1

au BufWritePre *.css,*.svelte,*.pcss,*.html,*.ts,*.js,*.json,*.yml,*.yaml PrettierAsync
