return function()
    local nightfox = require("nightfox")

    nightfox.setup({
        fox = "nordfox",
        transparent = true,
        terminal_colors = true,
    })

    nightfox.load()
end
