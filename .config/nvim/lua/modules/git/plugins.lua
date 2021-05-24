local git = {}
local config = require('modules.git.config')

git['ThePrimeagen/git-worktree.nvim'] = {config = config.git_worktree}

git['tpope/vim-fugitive'] = {cmd = 'Git'}
git['junegunn/gv.vim'] = {cmd = "GV"}

return git
