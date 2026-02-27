require("gitsigns").setup({
	signs = {
		add = { text = "+" },
		change = { text = "~" },
		delete = { text = "-" },
		topdelete = { text = "‾" },
		changedelete = { text = "~" },
		untracked = { text = "┆" },
	},
	on_attach = function(bufnr)
		local gs = package.loaded.gitsigns

		-- Navigation
		vim.keymap.set("n", "]c", function()
			if vim.wo.diff then
				return "]c"
			end
			vim.schedule(function()
				gs.next_hunk()
			end)
			return "<Ignore>"
		end, { expr = true, buffer = bufnr, desc = "Next hunk" })

		vim.keymap.set("n", "[c", function()
			if vim.wo.diff then
				return "[c"
			end
			vim.schedule(function()
				gs.prev_hunk()
			end)
			return "<Ignore>"
		end, { expr = true, buffer = bufnr, desc = "Prev hunk" })

		-- GitSigns actions with which-key descriptions
		local keymap = vim.keymap.set
		local opts = { buffer = bufnr }

		-- Stage actions
		keymap("n", "<leader>hs", gs.stage_hunk, { desc = "Stage hunk", buffer = bufnr })
		keymap("v", "<leader>hs", function()
			gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
		end, { desc = "Stage hunk", buffer = bufnr })

		-- Reset actions
		keymap("n", "<leader>hr", gs.reset_hunk, { desc = "Reset hunk", buffer = bufnr })
		keymap("v", "<leader>hr", function()
			gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
		end, { desc = "Reset hunk", buffer = bufnr })

		-- Buffer actions
		keymap("n", "<leader>hS", gs.stage_buffer, { desc = "Stage buffer", buffer = bufnr })
		keymap("n", "<leader>hR", gs.reset_buffer, { desc = "Reset buffer", buffer = bufnr })
		keymap("n", "<leader>hu", gs.undo_stage_hunk, { desc = "Undo stage hunk", buffer = bufnr })

		-- Preview actions
		keymap("n", "<leader>hp", gs.preview_hunk, { desc = "Preview hunk", buffer = bufnr })
		keymap("n", "<leader>hb", function()
			gs.blame_line({ full = true })
		end, { desc = "Blame line", buffer = bufnr })

		-- Toggle actions
		keymap("n", "<leader>tb", gs.toggle_current_line_blame, { desc = "Toggle blame line", buffer = bufnr })
		keymap("n", "<leader>td", gs.toggle_deleted, { desc = "Toggle deleted", buffer = bufnr })

		-- Diff actions
		keymap("n", "<leader>hd", gs.diffthis, { desc = "Diff this", buffer = bufnr })
		keymap("n", "<leader>hD", function()
			gs.diffthis("~")
		end, { desc = "Diff this ~", buffer = bufnr })

		-- Text object
		keymap({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", { desc = "Select hunk", buffer = bufnr })
	end,
})
