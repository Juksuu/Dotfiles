local function enableTreesitter(lang, buf)
    if vim.treesitter.language.add(lang) then
        local bufferExists = false
        for _, v in ipairs(vim.api.nvim_list_bufs()) do
            if v == buf then
                bufferExists = true
                break
            end
        end

        if not bufferExists then
            return
        end

        local parser = vim.treesitter.get_parser(buf, lang)
        if parser then
            parser:invalidate()
        end

        -- Highlights
        if vim.treesitter.query.get(lang, "highlights") then
            vim.treesitter.start(buf, lang)
        end

        -- Indentation
        -- if vim.treesitter.query.get(lang, "indents") then
        --     vim.opt_local.indentexpr =
        --         'v:lua.require("nvim-treesitter").indentexpr()'
        -- end

        -- Folding
        -- if vim.treesitter.query.get(lang, "folds") then
        --     vim.opt_local.foldmethod = "expr"
        --     vim.opt_local.foldexpr = "v:lua.vim.treesitter.foldexpr()"
        -- end
    end
end

vim.api.nvim_create_autocmd("FileType", {
    group = vim.api.nvim_create_augroup("tree-sitter-enable", { clear = true }),
    callback = function(args)
        local lang = vim.treesitter.language.get_lang(args.match)
        if not lang then
            return
        end

        local parsers = require("nvim-treesitter.parsers")
        if parsers[lang] == nil then
            return
        end

        require("nvim-treesitter").install({ lang }):await(function()
            enableTreesitter(lang, args.buf)
        end)
    end,
})
