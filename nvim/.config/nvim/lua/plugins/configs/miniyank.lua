return function()
    vim.keymap.set("n", "p", "<Plug>(miniyank-autoput)")
    vim.keymap.set("n", "P", "<Plug>(miniyank-autoPut)")

    vim.keymap.set("n", "<M-p>", "<Plug>(miniyank-cycle)")
    vim.keymap.set("n", "<M-n>", "<Plug>(miniyank-cycleback)")
end
