local git = {}
local config = require('modules.git.config')

git['ThePrimeagen/git-worktree.nvim'] = {
    config = config.git_worktree
}

git['tpope/vim-fugitive'] = {}
git['junegunn/gv.vim'] = {}

return git
