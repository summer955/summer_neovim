local vault_path = vim.fn.expand("$OBSIDIAN_VAULT_PATH")

if vault_path == "" then
	vim.notify("OBSIDIAN_VAULT_PATH 未设置，回退到默认路径", vim.log.levels.WARN)
	vault_path = vim.fn.expand("~/vaults/personal")
end

return {
	"obsidian-nvim/obsidian.nvim",
	version = "*",
	ft = "markdown",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-telescope/telescope.nvim",
	},
	opts = {
		legacy_commands = false,
		workspaces = {
			{
				name = "personal",
				path = vault_path,
			},
		},
		picker = {
			name = "telescope.nvim",
		},
	},
	keys = {
		{
			"<CR>",
			function()
				if require("obsidian").util.cursor_on_markdown_link() then
					return "<cmd>Obsidian follow_link<CR>"
				else
					return "<CR>"
				end
			end,
			expr = true,
			ft = "markdown",
			desc = "Obsidian: 链接跳转 / 普通换行",
		},
	},
}
