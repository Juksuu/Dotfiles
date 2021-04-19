local languages = {}
local config = require('modules.languages.config')

languages['leafOfTree/vim-svelte-plugin'] = {
    ft = "svelte",
    config = config.svelte
}

languages['nvim-treesitter/nvim-treesitter'] = {
    event = 'BufRead',
    after = 'telescope.nvim',
    config = config.treesitter
}

return languages
