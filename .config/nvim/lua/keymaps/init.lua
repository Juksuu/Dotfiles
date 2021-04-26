local bind = require('keymaps.bind')
local map_cr = bind.map_cr
local map_cmd = bind.map_cmd
require('keymaps.config')

local plug_map = {
    ["i|<TAB>"]      = map_cmd('v:lua.tab_complete()'):with_expr():with_silent(),
    ["i|<S-TAB>"]    = map_cmd('v:lua.s_tab_complete()'):with_silent():with_expr(),
    ["i|<CR>"]       = map_cmd([[compe#confirm({ 'keys': "\<Plug>delimitMateCR", 'mode': '' })]]):with_noremap():with_expr():with_nowait(),

    -- Packer
    ["n|<leader>pu"]     = map_cr("PackerUpdate"):with_silent():with_noremap():with_nowait();
    ["n|<leader>pi"]     = map_cr("PackerInstall"):with_silent():with_noremap():with_nowait();
    ["n|<leader>pc"]     = map_cr("PackerCompile"):with_silent():with_noremap():with_nowait();

    -- Git
    ["n|<leader>gs"]     = map_cr(":vert :botright :Git"):with_silent();
    ["n|<leader>gn"]     = map_cmd("v:lua.create_worktree()"):with_silent();
    ["n|<leader>gw"]     = map_cmd("<cmd>lua require('telescope').extensions.git_worktree.git_worktrees()<CR>");

    -- Harpoon
    ["n|<leader>th"]     = map_cmd("<cmd>lua require('harpoon.term').gotoTerminal(1)<CR>");
    ["n|<leader>tj"]     = map_cmd("<cmd>lua require('harpoon.term').gotoTerminal(2)<CR>");
    ["n|<leader>tk"]     = map_cmd("<cmd>lua require('harpoon.term').gotoTerminal(3)<CR>");
    ["n|<leader>tl"]     = map_cmd("<cmd>lua require('harpoon.term').gotoTerminal(4)<CR>");

    -- Lsp mapp work when insertenter and lsp start
    ["n|<leader>li"]     = map_cr("LspInfo"):with_noremap():with_silent():with_nowait(),
    ["n|<leader>ll"]     = map_cr("LspLog"):with_noremap():with_silent():with_nowait(),
    ["n|<leader>lr"]     = map_cr("LspRestart"):with_noremap():with_silent():with_nowait(),

    ["n|<leader>cf"]     = map_cr('Lspsaga lsp_finder'):with_noremap():with_silent(),
    ["n|<leader>ca"]     = map_cr("Lspsaga code_action"):with_noremap():with_silent(),
    ["n|<leader>cr"]     = map_cr('Lspsaga rename'):with_noremap():with_silent(),
    ["n|<leader>cs"]     = map_cr('Lspsaga signature_help'):with_noremap():with_silent(),
    ["n|<Leader>dl"]     = map_cr('Lspsaga show_line_diagnostics'):with_noremap():with_silent(),
    ["n|<leader>dn"]     = map_cr('Lspsaga diagnostic_jump_next'):with_noremap():with_silent(),
    ["n|<leader>dp"]     = map_cr('Lspsaga diagnostic_jump_prev'):with_noremap():with_silent(),
    ["n|K"]              = map_cr("Lspsaga hover_doc"):with_noremap():with_silent(),

    ["n|<leader>dt"]     = map_cr("LspTroubleOpen"):with_noremap():with_silent(),

    -- nvim-tree
    ["n|<leader>n"]      = map_cr('NvimTreeToggle'):with_noremap():with_silent(),

    -- undotree
    ["n|<leader>u"]      = map_cr('UndotreeToggle'):with_noremap():with_silent();
};

bind.nvim_load_mapping(plug_map)

-- Telescope bindings
local map_tele = function(key, f, options, buffer)
  local mode = "n"
  local rhs = string.format(
    "<cmd>lua R('modules.utils.telescope')['%s'](%s)<CR>",
    f,
    options and vim.inspect(options, { newline = '' }) or ''
  )

  local opts = {
    noremap = true,
    silent = true,
  }

  if not buffer then
    vim.api.nvim_set_keymap(mode, key, rhs, opts)
  else
    vim.api.nvim_buf_set_keymap(0, mode, key, rhs, opts)
  end
end

-- Files
map_tele('<leader>ff', 'find_files')
map_tele('<leader>fg', 'git_files')
map_tele('<leader>fs', 'live_grep')

-- Nvim
map_tele('<leader>fb', 'buffers')
map_tele('<leader>fB', 'curbuf')
