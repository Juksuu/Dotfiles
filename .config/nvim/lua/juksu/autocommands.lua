local u = require('juksu.utils')

u.create_augroup('highlightyank', {
    'TextYankPost * silent! lua require("vim.highlight").on_yank()'
})
