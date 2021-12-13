return function()
    local onedarkpro = require("onedarkpro")
    onedarkpro.setup({
        theme = "onedark",
        options = {
            bold = true,
            italic = false,
            underline = true,
            undercurl = true,
            cursorline = true,
            transparency = true,
        },
    })
    onedarkpro.load()
end
