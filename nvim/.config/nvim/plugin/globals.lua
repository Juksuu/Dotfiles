function RELOAD(name)
    require("plenary.reload").reload_module(name)
end

function RELOAD_RETURN(name)
    RELOAD(name)
    return require(name)
end
