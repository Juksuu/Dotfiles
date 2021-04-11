local nnoremap = vim.keymap.nnoremap

nnoremap { '<leader>th', function() require('harpoon.term').gotoTerminal(1) end}
nnoremap { '<leader>tj', function() require('harpoon.term').gotoTerminal(2) end}
nnoremap { '<leader>tk', function() require('harpoon.term').gotoTerminal(3) end}
nnoremap { '<leader>tl', function() require('harpoon.term').gotoTerminal(4) end}
