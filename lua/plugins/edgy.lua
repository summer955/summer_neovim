return {
	{
		"folke/edgy.nvim",
		event = "VeryLazy",
		init = function()
			vim.opt.laststatus = 3
			vim.opt.splitkeep = "screen"
		end,
		opts = {
			bottom = {
				{
					ft = "lazyterm",
					title = "LazyTerm",
					size = { height = 0.4 },
					filter = function(buf)
						return not vim.b[buf].lazyterm_cmd
					end,
				},
				-- {
				-- 	ft = "noice",
				-- 	filter = function(buf, win)
				-- 		return vim.api.nvim_win_get_config(win).relative == ""
				-- 	end,
				-- },
				{
					ft = "trouble",
					title = "󱖫 Trouble",
					size = { height = 0.2 },
				},
				{
					ft = "help",
					size = { height = 0.3 },
					-- only show help buffers
					filter = function(buf)
						return vim.bo[buf].buftype == "help"
					end,
				},
				{ title = "Neotest Output", ft = "neotest-output-panel", size = { height = 15 } },
			},
			left = {
				-- Neo-tree filesystem always takes half the screen height
				{
					title = "Neo-Tree",
					ft = "neo-tree",
					filter = function(buf)
						return vim.b[buf].neo_tree_source == "filesystem"
					end,
					size = { height = 0.25 },
				},
				{
					title = "Neo-Tree Git",
					ft = "neo-tree",
					filter = function(buf)
						return vim.b[buf].neo_tree_source == "git_status"
					end,
					pinned = true,
					collapsed = true, -- show window as closed/collapsed on start
					open = "Neotree position=right git_status",
				},
				{
					title = "Neo-Tree Buffers",
					ft = "neo-tree",
					filter = function(buf)
						return vim.b[buf].neo_tree_source == "buffers"
					end,
					pinned = true,
					collapsed = true, -- show window as closed/collapsed on start
					open = "Neotree position=top buffers",
				},
				{
					title = function()
						local buf_name = vim.api.nvim_buf_get_name(0) or "[No Name]"
						return vim.fn.fnamemodify(buf_name, ":t")
					end,
					ft = "Outline",
					pinned = true,
					open = "AerialToggle",
				},
				-- any other neo-tree windows
				"neo-tree",
			},
			right = {
				{ title = "Grug Far", ft = "grug-far", size = { width = 0.4 } },
				{
					ft = "json.kulala_ui",
					title = "API Response(kulala)",
					size = { width = 0.35 },
				},
				{
					title = "󰧭 Symbols",
					ft = "aerial",
					size = { width = 0.2 },
					filter = function(buf)
						return vim.bo[buf].filetype == "aerial"
					end,
				},
			},
			keys = {
				-- increase width
				["<c-Right>"] = function(win)
					win:resize("width", 2)
				end,
				-- decrease width
				["<c-Left>"] = function(win)
					win:resize("width", -2)
				end,
				-- increase height
				["<c-Up>"] = function(win)
					win:resize("height", 2)
				end,
				-- decrease height
				["<c-Down>"] = function(win)
					win:resize("height", -2)
				end,
			},
		},
	},
}
