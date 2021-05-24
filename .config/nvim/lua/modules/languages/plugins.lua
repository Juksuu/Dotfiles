local languages = {}
local config = require('modules.languages.config')

languages['sheerun/vim-polyglot'] = {config = config.polyglot}

languages['nvim-treesitter/nvim-treesitter'] = {
    event = 'BufRead',
    after = 'telescope.nvim',
    config = config.treesitter
}

return languages
