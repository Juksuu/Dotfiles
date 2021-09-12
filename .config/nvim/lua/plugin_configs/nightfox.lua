return function()
    local nightfox = require('nightfox')

    nightfox.setup({
        fox = "nordfox",
        transparent = true,
        terminal = true,
        styles = {
            comments = "italic", -- change style of comments to be italic
            keywords = "bold", -- change style of keywords to be bold
            functions = "italic,bold" -- styles can be a comma separated list
        }
    })

    nightfox.load()
end
