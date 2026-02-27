return {
	"stevearc/conform.nvim",
	event = { "BufWritePre" },
	cmd = { "ConformInfo" },
	lazy = true,
	keys = {
		{
			"<leader>cf",
			function()
				require("conform").format({ async = true, lsp_fallback = true })
			end,
			desc = "Format buffer",
		},
	},
	opts = {
		formatters_by_ft = {
			lua = { "stylua" },
			python = { "ruff_format" },
			c = { "clang_format" },
			cpp = { "clang_format" },
			java = { "google-java-format" },
			sh = { "shfmt" },
			yaml = { "yamlfmt" },
			yml = { "yamlfmt" },
			dockercompose = { "yamlfmt" },
		},
		format_on_save = { timeout_ms = 500, lsp_fallback = true },
		formatters = {
			shfmt = {
				prepend_args = { "-i", "2" },
			},
		},
	},
	init = function()
		vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
	end,
}
