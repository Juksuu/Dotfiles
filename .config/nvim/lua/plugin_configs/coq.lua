return function()
    vim.g.coq_settings = {
        auto_start = true and "shut-up",
        display = {
            pum = {
                fast_close = false,
            },
        },
        clients = {
            lsp = {
                resolve_timeout = 0.16,
            },
            buffers = {
                match_syms = true,
            },
        },
        limits = {
            completion_auto_timeout = 0.16,
        },
    }

    vim.cmd([[
        let g:coq_settings.keymap = {}
        let g:coq_settings.keymap.repeat = '<c-.>'
    ]])
end
