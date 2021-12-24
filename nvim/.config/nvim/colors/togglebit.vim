set background=dark 

highlight clear Signcolumn
highlight LineNr                   ctermfg=15
highlight IncSearch    ctermbg=3   ctermfg=1
highlight Search       ctermbg=1   ctermfg=3
highlight VertSplit    ctermbg=6   ctermfg=0
highlight Search       ctermbg=52  ctermfg=15
highlight Visual       ctermbg=240
highlight MatchParen   ctermbg=241
highlight ColorColumn  ctermbg=234

highlight CursorLine   ctermbg=236
highlight CursorLineNr ctermbg=23  ctermfg=7

highlight SpellBad     ctermbg=0  ctermfg=1
highlight SpellCap     ctermbg=4  ctermfg=15
highlight SpellLocal   ctermbg=55

highlight PmenuSel     ctermbg=3
highlight Pmenu        ctermbg=236 ctermfg=15

highlight DiffAdd      ctermbg=2 ctermfg=0
highlight DiffDelete   ctermbg=1 ctermfg=0
highlight DiffChange   ctermbg=4 ctermfg=0

" GitSigns
highlight GitSignsAdd     ctermfg=2
highlight GitSignsDelete  ctermfg=1
highlight GitSignsChange  ctermfg=4

" Tab line
highlight TabLine     ctermbg=236 ctermfg=230 term=NONE cterm=NONE
highlight TabLineSel  ctermbg=240 ctermfg=7   term=NONE cterm=bold
highlight TabLineFill ctermbg=234 ctermfg=7   term=NONE cterm=NONE

" Telescope
highlight TelescopeMatching ctermfg=3

" Nvim cmp
highlight CmpItemAbbrMatch      ctermfg=14
highlight CmpItemAbbrMatchFuzzy ctermfg=14
highlight CmpItemAbbrDeprecated ctermfg=1  cterm=strikethrough

highlight CmpItemKindVariable  ctermfg=1
highlight CmpItemKindInterface ctermfg=1

highlight CmpItemKindMethod   ctermfg=2
highlight CmpItemKindFunction ctermfg=2

highlight CmpItemKindText     ctermfg=15
highlight CmpItemKindUnit     ctermfg=15
highlight CmpItemKindKeyword  ctermfg=15
highlight CmpItemKindProperty ctermfg=15
