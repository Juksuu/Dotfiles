--Enable typescript lsp
vim.lsp.enable("ts_ls")

-- Enable formatters
local conform_available, conform = pcall(require, "conform")
if conform_available then
	local formatters = {
		typescript = { "prettierd" },
		typescriptreact = { "prettierd" },
	}
	conform.formatters_by_ft = vim.tbl_extend("force", conform.formatters_by_ft, formatters)
end
