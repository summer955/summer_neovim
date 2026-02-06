require("mason-lspconfig").setup({
	automatic_enable = {
		exclude = {
			"ruff",
		},
	},
})

-- lua
vim.lsp.config("lua_ls", {
	settings = {
		Lua = {
			diagnostics = {
				globals = { "vim", "Snacks" },
			},
		},
	},
})

-- c,c++
vim.lsp.config("clangd", {
	cmd = {
		"clangd",
		"--header-insertion=never",
		"--query-driver=/opt/homebrew/opt/llvm/bin/clang",
		"--all-scopes-completion",
		"--completion-style=detailed",
	},
})

--java

vim.lsp.config("jdtls", { cmd = { "jdtls" } })

--python
vim.lsp.config("pyright", {
	settings = {
		python = {
			analysis = {
				autoSearchPaths = true,
				diagnosticMode = "openFilesOnly",
				useLibraryCodeForTypes = true,
			},
		},
	},
})
