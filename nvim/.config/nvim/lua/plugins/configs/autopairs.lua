local present, autopairs = pcall(require, "nvim-autopairs")
if present then
    autopairs.setup({
        map_cr = true,
    })
end
