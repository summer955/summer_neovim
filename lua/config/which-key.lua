local wk = require("which-key")

wk.add({
	{ "<F11>", "<cmd>UndotreeToggle<cr>", desc = "open UndoTree", mode = "n" },
	{ "<leader>c", group = "Code Actions" },
	{ "<leader>x", group = "Trouble List" },
	{ "<leader>h", group = "gitsigns Key" },
	{ "<leader>b", group = "Bufferline" },
	{ "<leader>g", group = "Git" },
	{ "<leader>s", group = "System and History Search" },
	{ "<leader>u", group = "Feature Toggle" },
	{ "<leader>d", group = "nvim-Dap keys" },
	{
		"<leader>cf",
		function()
			require("conform").format({ async = true, lsp_fallback = true })
		end,
		desc = "Format Current File",
		mode = "n",
	},
	{ "<leader>ci", "<cmd>IBLToggle<cr>", desc = "Turn on code alignment guides", mode = "n" },
	{ "<leader>cn", "<cmd>set number!<cr>", desc = "Toggle line numbers", mode = "n" },
})
