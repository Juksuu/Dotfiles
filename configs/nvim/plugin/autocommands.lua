vim.api.nvim_create_autocmd("TextYankPost", {
    callback = function()
        vim.hl.on_yank({ higroup = "IncSearch", timeout = 400 })
    end,
})

-- Source project local nvim configuration
local PROJECT_CONFIG_FILE_NAME = ".nvim.lua"
local project_config_augroup = vim.api.nvim_create_augroup("project_config", {})
vim.api.nvim_create_autocmd("DirChanged", {
    group = project_config_augroup,
    callback = function(args)
        local contents = vim.secure.read(
            string.format("%s/%s", args.file, PROJECT_CONFIG_FILE_NAME)
        )
        if contents then
            assert(loadstring(contents))()
        end
    end,
})
vim.api.nvim_create_autocmd("VimEnter", {
    group = project_config_augroup,
    callback = function()
        local contents = vim.secure.read(
            string.format("%s/%s", vim.fn.getcwd(), PROJECT_CONFIG_FILE_NAME)
        )
        if contents then
            assert(loadstring(contents))()
        end
    end,
})
