local download_packer = function()
    print("Downloading packer.nvim...")

    local directory = string.format("%s/site/pack/packer/start/",
                                    vim.fn.stdpath "data")

    vim.fn.mkdir(directory, "p")

    vim.fn.system(string.format("git clone %s %s",
                                "https://github.com/wbthomason/packer.nvim",
                                directory .. "/packer.nvim"))

    print("( You'll need to restart now )")
end

return function()
    if not pcall(require, "packer") then
        download_packer()

        return true
    end

    return false
end
