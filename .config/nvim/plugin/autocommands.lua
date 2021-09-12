-- TEXT YANK HIGHLIGHT

vim.api.nvim_exec([[
    augroup textyankpost
    au!
    au TextYankPost * lua vim.highlight.on_yank({ timeout=400 })
    augroup end
    ]], false)
