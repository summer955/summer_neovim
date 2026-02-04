return {
	{
		"folke/tokyonight.nvim",
		lazy = false,
		priority = 1000,
		-- opts = {
		-- 	transparent = true,
		-- 	styles = {
		-- 		sidebars = "transparent",
		-- 		floats = "transparent",
		-- 	},
		-- },
		config = function()
			vim.cmd([[colorscheme tokyonight-moon]])
		end,
	},
	{
		"nvim-lualine/lualine.nvim",
		event = { "BufRead", "BufNewFile" },
		config = function()
			require("lualine").setup({
				options = {
					theme = "palenight",
					globalstatus = vim.o.laststatus == 3,
					disabled_filetypes = {
						statusline = {
							"dashboard",
							"snacks_dashboard",
						},
					},
				},
			})
		end,
	},
	{
		"mbbill/undotree",
		event = { "BufRead", "BufNewFile" },
	},
	{
		"christoomey/vim-tmux-navigator",
		cmd = {
			"TmuxNavigateLeft",
			"TmuxNavigateDown",
			"TmuxNavigateUp",
			"TmuxNavigateRight",
			"TmuxNavigatePrevious",
		},
		keys = {
			{ "<c-h>", "<cmd><C-U>TmuxNavigateLeft<cr>" },
			{ "<c-j>", "<cmd><C-U>TmuxNavigateDown<cr>" },
			{ "<c-k>", "<cmd><C-U>TmuxNavigateUp<cr>" },
			{ "<c-l>", "<cmd><C-U>TmuxNavigateRight<cr>" },
			{ "<c-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>" },
		},
		init = function()
			vim.g.tmux_navigator_no_wrap = 1
		end,
	},
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		config = function()
			require("config.which-key")
		end,
	},
	{
		"nvim-neo-tree/neo-tree.nvim",
		version = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons",
			"MunifTanjim/nui.nvim",
		},
		keys = {
			{
				"<leader>ee",
				function()
					require("neo-tree.command").execute({ toggle = true })
				end,
				desc = "Explorer",
			},
			{
				"<leader>eb",
				function()
					require("neo-tree.command").execute({ source = "buffers", toggle = true })
				end,
				desc = "Buffer explorer",
			},
			{
				"<leader>eg",
				function()
					require("neo-tree.command").execute({ source = "git_status", toggle = true })
				end,
				desc = "Git explorer",
			},
		},
		opts = {
			sources = { "filesystem", "buffers", "git_status" },
			open_files_do_not_replace_types = { "terminal", "Trouble", "trouble", "qf", "Outline" },
			filesystem = {
				bind_to_cwd = false,
				follow_current_file = { enabled = true },
				use_libuv_file_watcher = true,
			},
			window = {
				width = 30,
				position = "left",
			},
			default_component_configs = {
				git_status = {
					symbols = {
						unstaged = "U",
						staged = "[✓]",
					},
				},
				indent = {
					with_expanders = true, -- if nil and file nesting is enabled, will enable expanders
					expander_collapsed = "",
					expander_expanded = "",
					expander_highlight = "NeoTreeExpander",
				},
			},
		},
		config = function(_, opts)
			require("neo-tree").setup(opts)
		end,
	},
	{
		"kylechui/nvim-surround",
		version = "^3.0.0",
		event = "VeryLazy",
		config = function()
			require("nvim-surround").setup({
				-- Configuration here, or leave empty to use defaults
			})
		end,
	},
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		opts = {
			check_ts = true,
			ts_config = { java = false },
			fast_wrap = {
				map = "<M-e>",
				chars = { "{", "[", "(", '"', "'" },
				pattern = string.gsub([[ [%'%"%)%>%]%)%}%,] ]], "%s+", ""),
				offset = 0,
				end_key = "$",
				keys = "qwertyuiopzxcvbnmasdfghjkl",
				check_comma = true,
				highlight = "PmenuSel",
				highlight_grey = "LineNr",
			},
		},
	},
	-- Treesitter
	{
		"nvim-treesitter/nvim-treesitter",
		dependencies = {
			"nvim-treesitter/nvim-treesitter-textobjects",
		},
		version = "*",
		event = { "BufRead", "BufNewFile" },
		build = ":TSUpdate",
		config = function()
			require("config.treesitter")
		end,
	},
	{
		"romgrk/nvim-treesitter-context",
		event = { "BufRead", "BufNewFile" },
		config = function()
			require("treesitter-context").setup({
				enable = true,
				throttle = true,
				max_lines = 0,
				patterns = {
					default = {
						"class",
						"function",
						"method",
					},
				},
			})
		end,
	},
	{
		"JoosepAlviste/nvim-ts-context-commentstring",
		event = { "BufRead", "BufNewFile" },
	},
	{
		"numToStr/Comment.nvim",
		event = { "BufRead", "BufNewFile" },
		opts = function()
			return {
				pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
			}
		end,
	},
	-- LSP config
	{

		"mason-org/mason.nvim",
		lazy = true,
		cmd = { "Mason", "MasonInstall", "MasonUpdate" },
		keys = { { "<leader>cm", "<cmd>Mason<cr>", desc = "Mason" } },
		build = ":MasonUpdate",
		opts_extend = { "ensure_installed" },
		opts = {
			ui = {
				icons = {
					package_installed = "✓",
					package_pending = "➜",
					package_uninstalled = "✗",
				},
			},
			ensure_installed = {
				-- LSP server
				"lua-language-server", -- lua_ls
				"clangd", -- cpp
				"pyright", --python
				-- 请运行 "apt install openjdk-17-jdk"
				"jdtls", -- java
				-- "java_language_server",

				-- Formatter
				"stylua", -- lua
				"ruff", -- python
				"clang-format", -- cpp
				"google-java-format", --java
				"shfmt", -- shell

				-- Linter
				"flake8", -- python
				"selene", -- lua
				"cpplint", -- cpp
			},
		},
		---@param opts MasonSettings | {ensure_installed: string[]}
		config = function(_, opts)
			require("mason").setup(opts)
			local mr = require("mason-registry")
			mr:on("package:install:success", function()
				vim.defer_fn(function()
					-- trigger FileType event to possibly load this newly installed LSP server
					require("lazy.core.handler.event").trigger({
						event = "FileType",
						buf = vim.api.nvim_get_current_buf(),
					})
				end, 100)
			end)

			mr.refresh(function()
				for _, tool in ipairs(opts.ensure_installed) do
					local p = mr.get_package(tool)
					if not p:is_installed() then
						p:install()
					end
				end
			end)
		end,
	},
	{
		"mfussenegger/nvim-lint",
		event = { "BufWritePost", "BufReadPost", "InsertLeave" },
		config = function()
			local os = require("os")

			require("lint").linters_by_ft = {
				python = { "ruff" },
				lua = { "selene" },
				cpp = { "cpplint" },
				c = { "cpplint" },
			}

			require("lint").linters.selene.args = {
				"--display-style",
				"quiet", -- quiet mode
				"--config",
				os.getenv("HOME") .. "/.config/selene-ignore.toml",
			}

			vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost", "InsertLeave" }, {
				callback = function()
					require("lint").try_lint()
				end,
			})
		end,
	},

	-- Mason LSP 桥接
	{
		"williamboman/mason-lspconfig.nvim",
		dependencies = {
			{ "mason-org/mason.nvim" },
			"neovim/nvim-lspconfig",
		},
		event = "VeryLazy",
		config = function()
			require("config.diagnostic")
			require("config.lsp")
		end,
	},
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"hrsh7th/cmp-nvim-lsp",
		},
	},

	-- 代码片段引擎
	{
		"L3MON4D3/LuaSnip",
		build = "make install_jsregexp",
		dependencies = { "rafamadriz/friendly-snippets" },
		opts = {
			history = true,
			delete_check_events = "TextChanged",
			region_check_events = "CursorMoved",
		},
	},

	-- 自动补全
	{
		"L3MON4D3/LuaSnip",
		-- build = "make install_jsregexp", -- 必需构建
		version = "v2.*",
		event = "InsertEnter",
		dependencies = {
			"rafamadriz/friendly-snippets", -- 预定义片段库
		},

		config = function()
			-- 加载 friendly-snippets
			require("luasnip.loaders.from_vscode").lazy_load()
		end,
	},
	{
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp", -- LSP 补全
			"hrsh7th/cmp-buffer", -- 缓冲区补全
			"hrsh7th/cmp-path", -- 路径补全
			"hrsh7th/cmp-cmdline", -- 命令行补全
			"saadparwaiz1/cmp_luasnip", -- LuaSnip 支持
			"onsails/lspkind-nvim", -- 美化图标
		},
		config = function()
			require("config.cmp")
		end,
	},
	{
		"HiPhish/rainbow-delimiters.nvim",
		event = { "BufRead", "BufNewFile" },
	},
	{
		"lukas-reineke/indent-blankline.nvim",
		event = { "BufRead", "BufNewFile" },
		main = "ibl",
		opts = {
			indent = { char = "¦" },
			scope = { show_start = false, show_end = false },
			exclude = {
				buftypes = {
					"nofile",
					"terminal",
				},
				filetypes = {
					"help",
					"startify",
					"aerial",
					"alpha",
					"dashboard",
					"lazy",
					"neogitstatus",
					"NvimTree",
					"neo-tree",
					"Trouble",
					"trouble",
					"mason",
					"toggleterm",
					"lazyterm",
					"notify",
					"qf",
				},
			},
		},
	},
	{
		"akinsho/toggleterm.nvim",
		version = "*",
		config = true,
		keys = "<F12>",
		opts = {
			size = 10,
			open_mapping = [[<F12>]],
			shading_factor = 2,
			direction = "float",
			float_opts = {
				border = "curved",
				highlights = { border = "Normal", background = "Normal" },
				width = function()
					return math.floor(vim.o.columns * 0.8)
				end,
				height = function()
					return math.floor(vim.o.lines * 0.6)
				end,
			},
		},
	},
	{
		"kevinhwang91/nvim-ufo",
		dependencies = "kevinhwang91/promise-async",
		event = { "BufRead", "BufNewFile" },
		config = function()
			require("config.ufo")
		end,
		opts = {
			preview = {
				mappings = {
					scrollB = "<C-b>",
					scrollF = "<C-f>",
					scrollU = "<C-u>",
					scrollD = "<C-d>",
				},
			},
		},
	},
	{
		"lewis6991/gitsigns.nvim",
		event = { "BufRead", "BufNewFile" },
		config = function()
			require("config.gitsigns")
		end,
	},
	{
		"farmergreg/vim-lastplace",
		event = { "BufRead", "BufNewFile" },
		init = function()
			vim.g.lastplace_ignore = "gitcommit,gitrebase,svn,hgcommit"
			vim.g.lastplace_ignore_buftype = "quickfix,nofile,help"
			vim.g.lastplace_open_folds = 0
		end,
	},
	{
		-- 检测缩进风格
		"nmac427/guess-indent.nvim",
		event = "BufReadPre",
		config = function()
			require("guess-indent").setup({
				auto_cmd = true,
				filetype_exclude = { "markdown", "text" },
			})
		end,
	},
	{
		"tpope/vim-fugitive",
		event = "VeryLazy",
	},
	{
		"andrewradev/splitjoin.vim",
		event = "InsertEnter",
	},
	{
		"junegunn/vim-easy-align",
		event = { "BufRead", "BufNewFile" },
		keys = {
			{ "ga", mode = { "n", "x" }, "<Plug>(EasyAlign)", desc = "EasyAlign" },
		},
	},
	{
		"folke/trouble.nvim",
		opts = {},
		cmd = "Trouble",
		keys = {
			{
				"<leader>xx",
				"<cmd>Trouble diagnostics toggle<cr>",
				desc = "Diagnostics (Trouble)",
			},
			{
				"<leader>xX",
				"<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
				desc = "Buffer Diagnostics (Trouble)",
			},
			{
				"<leader>cs",
				-- "<cmd>Trouble symbols toggle focus=false<cr>",
				-- desc = "Symbols (Trouble)",
				false,
			},
			{
				"<leader>cl",
				"<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
				desc = "LSP Definitions / references / ... (Trouble)",
			},
			{
				"<leader>xL",
				"<cmd>Trouble loclist toggle<cr>",
				desc = "Location List (Trouble)",
			},
			{
				"<leader>xQ",
				"<cmd>Trouble qflist toggle<cr>",
				desc = "Quickfix List (Trouble)",
			},
		},
	},
	{
		"nacro90/numb.nvim",
		event = { "BufRead", "BufNewFile" },
		config = function()
			require("numb").setup({
				show_numbers = true, -- 预览窗口显示行号
				show_cursorline = true, -- 预览窗口高亮光标行
			})
		end,
	},
	{
		"nvim-pack/nvim-spectre",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		cmd = "Spectre",
		keys = {
			{ "<leader>cp", "<cmd>Spectre<CR>", desc = "Spectre Panel" },
		},
		config = function()
			require("spectre").setup()
		end,
		lazy = true,
	},
	{
		"MagicDuck/grug-far.nvim",
		opts = { headerMaxWidth = 80 },
		cmd = { "GrugFar", "GrugFarWithin" },
		keys = {
			{
				"<leader>sr",
				function()
					local grug = require("grug-far")
					local ext = vim.bo.buftype == "" and vim.fn.expand("%:e")
					grug.open({
						transient = true,
						prefills = {
							filesFilter = ext and ext ~= "" and "*." .. ext or nil,
						},
					})
				end,
				mode = { "n", "x" },
				desc = "Search and Replace",
			},
		},
	},
	{
		"sindrets/diffview.nvim",
		event = { "BufRead", "BufNewFile" },
	},
	{
		"echasnovski/mini.cursorword",
		version = "*",
		event = { "BufRead", "BufNewFile" },
		config = function()
			require("mini.cursorword").setup()
		end,
	},
	{
		"echasnovski/mini.map",
		version = false,
		keys = {
			{
				"<F10>",
				"<cmd>:lua MiniMap.toggle()<CR>",
				desc = "MiniMap",
			},
		},
		config = function()
			local map = require("mini.map")
			map.setup({
				integrations = {
					map.gen_integration.builtin_search(),
					map.gen_integration.diff(),
					map.gen_integration.diagnostic(),
				},
				symbols = {
					encode = map.gen_encode_symbols.dot("4x2"),
					scroll_line = "▶ ",
					scroll_view = "▐ ",
				},
				window = {
					focusable = true,
				},
			})
		end,
	},
	{
		"folke/flash.nvim",
		event = "VeryLazy",
		opts = {
			modes = {
				char = { enabled = false },
			},
		},
		keys = {
			{
				"s",
				mode = { "n", "x", "o" },
				function()
					require("flash").jump()
				end,
				desc = "Flash",
			},
			{
				"S",
				mode = { "n", "o" },
				function()
					require("flash").treesitter()
				end,
				desc = "Flash Treesitter",
			},
			{
				"r",
				mode = "o",
				function()
					require("flash").remote()
				end,
				desc = "Remote Flash",
			},
			{
				"R",
				mode = { "o", "x" },
				function()
					require("flash").treesitter_search()
				end,
				desc = "Treesitter Search",
			},
			{
				"<c-s>",
				mode = { "c" },
				function()
					require("flash").toggle()
				end,
				desc = "Toggle Flash Search",
			},
		},
	},
	{
		"sphamba/smear-cursor.nvim",
		event = "VeryLazy",
		cond = vim.g.neovide == nil,
		opts = {
			hide_target_hack = true,
			cursor_color = "none",
		},
	},
	{
		"gbprod/yanky.nvim",
		dependencies = { "kkharji/sqlite.lua" },
		opts = {
			ring = {
				history_length = 100,
				storage = "sqlite",
				sync_with_numbered_registers = true,
				cancel_event = "update",
				ignore_registers = { "_" },
				update_register_on_cycle = false,
			},
			system_clipboard = {
				sync_with_ring = true,
			},
		},
		keys = {
			{
				"<leader>p",
				function()
					require("telescope").extensions.yank_history.yank_history({})
				end,
				desc = "Open Yank History",
			},
		},
	},
	{
		"folke/todo-comments.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		event = { "BufRead", "BufNewFile" },
		config = function()
			require("todo-comments").setup()
		end,
	},
	{
		"stevearc/aerial.nvim",
		event = "VeryLazy",
		config = function()
			require("aerial").setup({
				layout = {
					default_direction = "right", -- 右侧显示
					placement = "edge", -- 边缘对齐
					min_width = 30, -- 最小宽度
					max_width = 50, -- 最大宽度
				},

				show_guides = true, -- 显示指引线
				highlight_on_hover = true, -- 悬停高亮

				-- 后端
				backends = { "lsp", "treesitter" },

				-- 图标（使用 Nerd Font）
				nerd_font = "auto",

				guides = {
					mid_item = "├─",
					last_item = "└─",
					nested_top = "│ ",
					whitespace = "  ",
				},
			})
		end,
		keys = {
			{ "<leader>cs", "<cmd>AerialToggle<cr>", desc = "Aerial (Symbols)" },
		},
	},
	{ "MunifTanjim/nui.nvim", lazy = true },
	{
		"michaelb/sniprun",
		branch = "master",
		build = "sh install.sh",
		config = function()
			require("sniprun").setup({
				display = { "Terminal" },
				display_options = {
					terminal_scrollback = vim.o.scrollback, -- change terminal display scrollback lines
					terminal_line_number = false, -- whether show line number in terminal window
					terminal_signcolumn = false, -- whether show signcolumn in terminal window
					terminal_position = "horizontal", --# or "horizontal", to open as horizontal split instead of vertical split
					-- terminal_width = 45, --# change the terminal display option width (if vertical)
					terminal_height = 10, --# change the terminal display option height (if horizontal)
				},
			})
		end,
		keys = {
			{ "<leader>r", ":'<,'>SnipRun<CR>", mode = "v", desc = "Run selection" },
			{ "<leader>rr", ":%SnipRun<CR>", mode = "n", desc = "Run file" },
			-- 清除结果
			{
				"<leader>rc",
				":SnipClose<CR>",
				mode = "n",
				desc = "Clear results",
			},
		},
	},
	{
		"danymat/neogen",
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"L3MON4D3/LuaSnip",
		},
		keys = {
			{
				"<leader>cg",
				function()
					require("neogen").generate()
				end,
				desc = "Generate code annotations",
			},
		},
		opts = {
			snippet_engine = "luasnip",
		},
		config = true,
	},
	{
		"j-hui/fidget.nvim",
		event = "LspAttach",
		opts = {},
	},
}
