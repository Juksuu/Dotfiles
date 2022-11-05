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

local ensure_packer = function()
    local fn = vim.fn
    local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
    if fn.empty(fn.glob(install_path)) > 0 then
        fn.system({
            "git",
            "clone",
            "--depth",
            "1",
            "https://github.com/wbthomason/packer.nvim",
            install_path,
        })
        vim.cmd([[packadd packer.nvim]])
        return true
    end
    return false
end

local packer_bootstrap = ensure_packer()
local modules = {
    "packages.languages",
    "packages.utils",
    "packages.theme",
    "packages.git",
    "packages.search",
    "packages.completion",
    "packages.lsp",
}

local packer = require("packer")
return packer.startup({
    function(use)
        -- Packer can manage itself
        use("wbthomason/packer.nvim")

        for _, module in ipairs(modules) do
            for _, package in ipairs(RELOAD_RETURN(module)) do
                use(package)
            end
        end

        if packer_bootstrap then
            packer.sync()
        end
    end,
    config = {
        display = {
            open_fn = function()
                return require("packer.util").float({ border = "single" })
            end,
            prompt_border = "single",
        },
        compile_path = vim.fn.stdpath("config") .. "/lua/packer_compiled.lua",
    },
})
