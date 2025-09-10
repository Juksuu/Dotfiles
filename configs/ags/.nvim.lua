--Enable typescript lsp on project that has no lock files
vim.lsp.config["ts_ls"] = {
	root_dir = function(bufnr, on_dir)
		-- The project root is where the LSP can be started from
		-- As stated in the documentation above, this LSP supports monorepos and simple projects.
		-- We select then from the project root, which is identified by the presence of a package
		-- manager lock file.
		local root_markers = {
			"tsconfig.json",
			"package-lock.json",
			"yarn.lock",
			"pnpm-lock.yaml",
			"bun.lockb",
			"bun.lock",
			"deno.lock",
		}
		-- Give the root markers equal priority by wrapping them in a table
		root_markers = vim.fn.has("nvim-0.11.3") == 1 and { root_markers } or root_markers
		local project_root = vim.fs.root(bufnr, root_markers)
		if not project_root then
			return
		end

		on_dir(project_root)
	end,
}
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
