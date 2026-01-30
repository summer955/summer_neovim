require("mason-lspconfig").setup({

	-- ensure_installed = {
	--   -- LSP server
	--   "lua_ls",
	-- },

	handlers = {
		-- 默认处理器（为所有服务器）
		function(server_name)
			require("lspconfig")[server_name].setup({})
		end,

		-- Lua 特殊配置
		["lua_ls"] = function()
			require("lspconfig").lua_ls.setup({
				settings = {
					Lua = {
						diagnostics = {
							globals = { "vim" },
						},
					},
				},
			})
		end,

		-- C/C++ 特殊配置
		["clangd"] = function()
			require("lspconfig").clangd.setup({
				cmd = {
					"clangd",
					"--header-insertion=never",
					"--query-driver=/opt/homebrew/opt/llvm/bin/clang",
					"--all-scopes-completion",
					"--completion-style=detailed",
				},
			})
		end,

		-- Python 特殊配置
		["pyright"] = function()
			require("lspconfig").pyright.setup({})
		end,

		-- Java 特殊配置
		["jdtls"] = function()
			require("lspconfig").jdtls.setup({})
		end,
	},
})
