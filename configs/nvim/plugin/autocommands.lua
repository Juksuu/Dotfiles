vim.api.nvim_create_autocmd("TextYankPost", {
    callback = function()
        vim.hl.on_yank({ higroup = "IncSearch", timeout = 400 })
    end,
})

-- Source project local nvim configuration
local PROJECT_CONFIG_FILE_NAME = ".nvim.lua"
vim.api.nvim_create_autocmd("DirChanged", {
    callback = function(args)
        print("testing", vim.inspect(args.file))
        local contents = vim.secure.read(
            string.format("%s/%s", args.file, PROJECT_CONFIG_FILE_NAME)
        )
        if contents then
            assert(loadstring(contents))()
        end
    end,
})
