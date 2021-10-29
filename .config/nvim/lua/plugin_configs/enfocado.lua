return function()
    vim.g.enfocado_style = 'nature'

    -- Transparent bg
    vim.api.nvim_exec([[
        augroup enfocado_customization
          autocmd!
              autocmd ColorScheme enfocado highlight Normal ctermbg=NONE guibg=NONE
              autocmd ColorScheme enfocado highlight TabLineSel ctermbg=NONE guibg=NONE
        augroup end
    ]], false)

    vim.cmd [[
        autocmd VimEnter * ++nested colorscheme enfocado
    ]]
end
