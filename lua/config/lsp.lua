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

vim.lsp.config("yamlls", {
	settings = {
		yaml = {
			schemaStore = { enable = true },
			schemas = {
				["https://json.schemastore.org/github-workflow.json"] = "/.github/workflows/*",
				["https://raw.githubusercontent.com/yannh/kubernetes-json-schema/refs/heads/master/v1.29.1-standalone-strict/all.json"] = {
					"**/k8s/*.yaml", -- 匹配 /any/path/k8s/foo.yaml
					"**/k8s/*.yml",
					"*.k8s.yaml", -- 匹配根目录下的 *.k8s.yaml
				},
			},
		},
	},
})
