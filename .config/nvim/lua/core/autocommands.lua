local vim = vim
local autocmd = {}

function autocmd.nvim_create_augroups(definitions)
    for group_name, definition in pairs(definitions) do
        vim.api.nvim_command('augroup '..group_name)
        vim.api.nvim_command('autocmd!')
        for _, def in ipairs(definition) do
            local command = table.concat(vim.tbl_flatten{'autocmd', def}, ' ')
            vim.api.nvim_command(command)
        end
        vim.api.nvim_command('augroup END')
    end
end

function autocmd.load_autocmds()

    local definitions = {
        packer = {
            {"BufWritePost","*.lua","lua require('core.pack').auto_compile()"};
        },

        bufs = {
            {"BufWritePre","/tmp/*","setlocal noundofile"};
            {"BufWritePre","COMMIT_EDITMSG","setlocal noundofile"};
            {"BufWritePre","MERGE_MSG","setlocal noundofile"};
            {"BufWritePre","*.tmp","setlocal noundofile"};
            {"BufWritePre","*.bak","setlocal noundofile"};
            { "BufWritePre","*.css,*.svelte,*.pcss,*.html,*.ts,*.tsx,*.js,*.jsx,*.json,*.yml,*.yaml","PrettierAsync" };
        };

        wins = {
            -- Equalize window dimensions when resizing vim window
            {"VimResized", "*", [[tabdo wincmd =]]};
            -- Force write shada on leaving nvim
            {"VimLeave", "*", [[if has('nvim') | wshada! | else | wviminfo! | endif]]};
        };

        yank = {
            {"TextYankPost", [[* silent! lua vim.highlight.on_yank({higroup="IncSearch", timeout=400})]]};
        };
    };

    autocmd.nvim_create_augroups(definitions)
end

autocmd.load_autocmds()
