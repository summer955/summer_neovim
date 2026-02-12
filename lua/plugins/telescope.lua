return {
	{
		"nvim-telescope/telescope.nvim",
		version = "*",
		dependencies = {
			{ "nvim-lua/plenary.nvim" },
			{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
			-- extensions
			{ "nvim-telescope/telescope-project.nvim" },
			{ "nvim-telescope/telescope-frecency.nvim" },
		},
		config = function()
			require("telescope").setup({
				defaults = {
					layout_strategy = "horizontal",
					sorting_strategy = "ascending",
					layout_config = {
						horizontal = {
							prompt_position = "top",
							preview_width = 0.55,
						},
						width = 0.87,
						height = 0.80,
					},
				},
				extensions = {
					fzf = {
						fuzzy = true,
						override_generic_sorter = true,
						override_file_sorter = true,
						case_mode = "smart_case",
					},

					project = {
						-- history search
						base_dirs = {
							{ ".", max_depth = 2 }, -- deep = 2
						},

						-- mode pattern
						pattern = { ".git", "package.json", "Cargo.toml", "Makefile", "go.mod" },

						-- auto discover
						silent_chdir = true,
						previewer = true,
					},
				},
			})

			--load extensions
			require("telescope").load_extension("fzf")
			require("telescope").load_extension("project")
			require("telescope").load_extension("frecency")
		end,
		keys = {
			{
				"<leader>fq",
				function()
					require("telescope.builtin").quickfix()
				end,
				desc = "Browse Quickfix",
			},
			{

				"<leader>fQ",
				function()
					require("telescope.builtin").quickfixhistory()
				end,
				desc = "Browse Quickfixhistory",
			},
			{
				"<leader>ff",
				function()
					require("telescope.builtin").find_files(require("telescope.themes").get_dropdown({}))
				end,
				desc = "search files",
			},
			{
				"<leader>fg",
				function()
					require("telescope.builtin").live_grep({})
				end,
				desc = "search contents",
			},
			{
				"<leader>fs",
				function()
					require("telescope.builtin").grep_string()
				end,
				desc = "Search word at cursor",
			},
			{
				"<leader>fb",
				function()
					require("telescope.builtin").buffers(require("telescope.themes").get_dropdown({}))
				end,
				desc = "Lists open buffers(current)",
			},
			{
				"<leader>fh",
				function()
					require("telescope.builtin").help_tags({})
				end,
				desc = "search Help tags",
			},
			{
				"<leader>fl",
				function()
					require("telescope.builtin").current_buffer_fuzzy_find({})
				end,
				desc = "Search the current file",
			},
			{
				"<leader>fr",
				function()
					require("telescope.builtin").oldfiles(require("telescope.themes").get_dropdown({}))
				end,
				desc = "Browse Recent Files",
			},
			{
				"<leader>fG",
				function()
					require("telescope.builtin").git_files(require("telescope.themes").get_dropdown({}))
				end,
				desc = "Find Git Files",
			},
			{
				"<leader>fe",
				function()
					require("telescope.builtin").treesitter()
				end,
				desc = "Treesitter Picker",
			},
			{
				"<leader>fc",
				function()
					require("telescope.builtin").commands()
				end,
				desc = "Lists available commands",
			},

			{
				"<leader>fC",
				function()
					require("telescope.builtin").command_history()
				end,
				desc = "Lists executed commands recently",
			},
			{
				"<leader>fk",
				function()
					require("telescope.builtin").keymaps()
				end,
				desc = "List Key Maps",
			},
			{
				"<leader>fm",
				function()
					require("telescope.builtin").marks()
				end,
				desc = "Jump to Mark",
			},
			{
				"<leader>fM",
				function()
					require("telescope.builtin").man_pages()
				end,
				desc = "show Man Pages",
			},
			{
				"<leader>fj",
				function()
					require("telescope.builtin").jumplist()
				end,
				desc = "Jumplist",
			},
			-- extensions key
			{
				"<leader>fp",
				function()
					require("telescope").extensions.project.project({ display_type = "full" })
				end,
				desc = "Browse Recent Projects",
				mode = "n",
			},
			{
				"<leader>fw",
				function()
					require("telescope").extensions.frecency.frecency(require("telescope.themes").get_dropdown({
						workspace = "CWD",
					}))
				end,
				desc = "Telescope Frecency(current Directory)",
				mode = "n",
			},
			{
				"<leader>ft",
				function()
					require("telescope").extensions.frecency.frecency()
				end,
				desc = "Telescope Frecency",
				mode = "n",
			},
		},
	},
}
