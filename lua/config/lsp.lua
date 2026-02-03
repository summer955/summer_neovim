require("mason-lspconfig").setup({
	automatic_enable = true,
})

vim.lsp.config("lua_ls", {
	settings = {
		Lua = {
			diagnostics = {
				globals = { "vim", "Snacks" },
			},
		},
	},
})

vim.lsp.config("clangd", {
	cmd = {
		"clangd",
		"--header-insertion=never",
		"--query-driver=/opt/homebrew/opt/llvm/bin/clang",
		"--all-scopes-completion",
		"--completion-style=detailed",
	},
})
