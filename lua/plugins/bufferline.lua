return {
	"akinsho/bufferline.nvim",
	version = "*",
	dependencies = "nvim-tree/nvim-web-devicons",
	event = "VeryLazy",
	keys = {
		{ "<leader>bp", "<Cmd>BufferLineTogglePin<CR>", desc = "Toggle Pin" },
		{ "<leader>bP", "<Cmd>BufferLineGroupClose ungrouped<CR>", desc = "Delete Non-Pinned Buffers" },
		{ "<leader>bo", "<Cmd>BufferLineCloseOthers<CR>", desc = "Delete Other Buffers" },
		{ "<leader>br", "<Cmd>BufferLineCloseRight<CR>", desc = "Delete Buffers to the Right" },
		{ "<leader>bl", "<Cmd>BufferLineCloseLeft<CR>", desc = "Delete Buffers to the Left" },
		{ "<leader>be", "<cmd>BufferLineMoveNext<CR>", desc = "BufferLineMoveNext" },
		{ "<leader>bb", "<cmd>BufferLineMovePrev<CR>", desc = "BufferLineMovePrev" },
		{ "<S-h>", "<cmd>BufferLineCyclePrev<cr>", desc = "Prev Buffer" },
		{ "<S-l>", "<cmd>BufferLineCycleNext<cr>", desc = "Next Buffer" },
		{ "[b", "<cmd>BufferLineCyclePrev<cr>", desc = "Prev Buffer" },
		{ "]b", "<cmd>BufferLineCycleNext<cr>", desc = "Next Buffer" },
	},
	config = function()
		require("bufferline").setup({
			options = {
				mode = "buffers",
				diagnostics = "nvim_lsp",
				separator_style = "slant",
				always_show_bufferline = true,
				offsets = {
					{
						filetype = "neo-tree",
						text = " File Explorer",
						text_align = "left",
						highlight = "Directory",
						padding = 0,
					},
					{
						filetype = "snacks_layout_box",
					},
					{
						filetype = "undotree",
						text = " Edit History",
						highlight = "Comment",
						text_align = "left",
						padding = 0,
					},
				},
			},
		})
	end,
}
