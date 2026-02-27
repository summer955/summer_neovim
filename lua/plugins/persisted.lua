return {
	"olimorris/persisted.nvim",
	lazy = true,
	cmd = {
		-- "Telescope persisted",
		"SessionSave",
		"SessionLoad",
		"SessionDelete",
		"SessionStop",
	},
	keys = {
		{ "<leader>l", desc = "Session Management" },
		{
			"<leader>ls",
			function()
				local ok, _ = pcall(require, "telescope")
				if ok then
					require("telescope").load_extension("persisted")
					require("telescope").extensions.persisted.persisted()
				else
					require("persisted").load()
				end
			end,
			desc = "Browse/Load Session",
		},
		{
			"<leader>la",
			function()
				require("persisted").save()
			end,
			desc = "Save Current Session",
		},
		{
			"<leader>ld",
			function()
				vim.ui.input({ prompt = "Session name to delete: " }, function(input)
					if input and input ~= "" then
						require("persisted").delete(input)
						vim.notify("Deleted session: " .. input, vim.log.levels.INFO)
					end
				end)
			end,
			desc = "Delete Session",
		},
		{
			"<leader>ll",
			function()
				require("persisted").load({ last = true })
			end,
			desc = "Load Last Session",
		},
	},
	config = function()
		local ok, _ = pcall(require, "telescope")
		if ok then
			require("telescope").load_extension("persisted")
		end

		require("persisted").setup({
			autosave = false, --  关闭自动保存
			save_dir = vim.fn.expand(vim.fn.stdpath("data") .. "/sessions/"),
			use_git_branch = true,
			autoload = false,
		})
	end,
}
