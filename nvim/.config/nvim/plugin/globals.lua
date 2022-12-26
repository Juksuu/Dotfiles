function RELOAD(name)
    local has_plenary, reload = pcall(require, "plenary.reload")
    if has_plenary then
        reload.reload_module(name)
    end
end

function RELOAD_RETURN(name)
    RELOAD(name)
    return require(name)
end
