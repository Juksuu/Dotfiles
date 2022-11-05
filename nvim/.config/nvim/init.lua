vim.g.mapleader = " "

local has_impatient, impatient = pcall(require, "impatient")
if has_impatient then
    impatient.enable_profile()
end
require("packages")
