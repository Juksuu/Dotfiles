return function()
    require("luasnip").config.set_config({
        history = true,
        updateevents = "TextChanged,TextChangedI",
    })
end
