local wk = require("which-key")

wk.add({
	{ "<F11>", "<cmd>UndotreeToggle<cr>", desc = "open UndoTree", mode = "n" },
	{ "<leader><leader>", group = "<leader> Extension" },
	{ "<leader>c", group = "Code Actions" },
	{ "<leader>x", group = "Trouble List" },
	{ "<leader>h", group = "gitsigns Key" },
	{ "<leader>b", group = "Bufferline" },
	{ "<leader>g", group = "Git" },
	{ "<leader>s", group = "System and History Search" },
	{ "<leader>u", group = "Feature Toggle" },
	{ "<leader>d", group = "Code Dap keys" },
	{ "<leader>r", group = "Run code" },
	{ "<leader>e", group = "Open File Explorer" },
	{
		"<leader>?",
		function()
			require("which-key").show({ global = false })
		end,
		desc = "Buffer Local Keymaps (which-key)",
	},
	{ "<leader>ci", "<cmd>IBLToggle<cr>", desc = "Turn on code alignment guides", mode = "n" },
	{ "<leader>cn", "<cmd>set number!<cr>", desc = "Toggle line numbers", mode = "n" },
})
