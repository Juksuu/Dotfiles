return function()
    vim.g.gruvbox_baby_keyword_style = "NONE"
    vim.g.gruvbox_baby_comment_style = "NONE"
    vim.g.gruvbox_baby_function_style = "NONE"
    vim.cmd("colorscheme gruvbox-baby")

    vim.cmd([[
        highlight Normal guibg=none ctermbg=none
        highlight NonText guibg=none ctermbg=none
    ]])
end
