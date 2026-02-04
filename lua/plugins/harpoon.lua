return {
	"ThePrimeagen/harpoon",
	branch = "harpoon2",
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		require("harpoon").setup({})
	end,
	keys = {
		{ "<leader>q", desc = "Select Harpoon Keys" },
		{
			"<leader>qa",
			function()
				require("harpoon"):list():add()
			end,
			desc = "Add list file",
		},
		{
			"<leader>qq",
			function()
				require("harpoon"):list():select(1)
			end,
			desc = "Select the first file in the list",
		},
		{
			"<leader>qw",
			function()
				require("harpoon"):list():select(2)
			end,
			desc = "Select the second file in the list",
		},
		{
			"<leader>qe",
			function()
				require("harpoon"):list():select(3)
			end,
			desc = "Select the third file in the list",
		},
		{
			"<leader>qr",
			function()
				require("harpoon"):list():select(4)
			end,
			desc = "Select the fourth file in the list",
		},
		{
			"<leader>qn",
			function()
				require("harpoon"):list():next()
			end,
			desc = "Select next file in the list",
		},
		{
			"<leader>qp",
			function()
				require("harpoon"):list():prev()
			end,
			desc = "Select prev file in the list",
		},
		{
			"<leader>qx",
			function()
				require("harpoon").ui:toggle_quick_menu(require("harpoon"):list())
			end,
			desc = "Open toggle_quick_menu",
		},
		{
			"<leader>fa",
			function()
				local conf = require("telescope.config").values
				local function toggle_telescope(harpoon_files)
					local file_paths = {}
					for _, item in ipairs(harpoon_files.items) do
						table.insert(file_paths, item.value)
					end

					require("telescope.pickers")
						.new({}, {
							prompt_title = "Harpoon",
							finder = require("telescope.finders").new_table({
								results = file_paths,
							}),
							previewer = conf.file_previewer({}),
							sorter = conf.generic_sorter({}),
						})
						:find()
				end
				toggle_telescope(require("harpoon"):list())
			end,
			desc = "Select file from telescope UI",
		},
	},
}
