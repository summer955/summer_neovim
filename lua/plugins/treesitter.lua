return {
	{
		"nvim-treesitter/nvim-treesitter",
		branch = "main",
		event = { "BufRead", "BufNewFile" },
		cmd = { "TSUpdate", "TSInstall", "TSLog", "TSUninstall" },
		build = function()
			local TS = require("nvim-treesitter")
			if not TS.get_installed then
				vim.notify(
					"Please restart Neovim and run `:TSUpdate` to use the `nvim-treesitter` **main** branch.",
					vim.log.levels.ERROR
				)
				return
			end
			TS.update(nil, { summary = true })
		end,
		opts = {},
		config = function(_, opts)
			require("nvim-treesitter").setup(opts)

			-- Install required parsers
			local ensure_installed = {
				"bash",
				"c",
				"diff",
				"html",
				"javascript",
				"jsdoc",
				"json",
				"lua",
				"luadoc",
				"luap",
				"markdown",
				"markdown_inline",
				"printf",
				"python",
				"query",
				"regex",
				"toml",
				"tsx",
				"typescript",
				"vim",
				"vimdoc",
				"xml",
				"yaml",
			}
			vim.schedule(function()
				local ok, installed = pcall(require("nvim-treesitter.config").get_installed)
				if ok then
					local to_install = vim.tbl_filter(function(lang)
						return not vim.tbl_contains(installed or {}, lang)
					end, ensure_installed)
					if #to_install > 0 then
						require("nvim-treesitter.install").install(to_install)
					end
				end
			end)

			-- Enable Neovim 0.12.3's built-in tree-sitter highlighting
			vim.api.nvim_create_autocmd({ "FileType" }, {
				pattern = "*",
				callback = function(args)
					local ignore_ft = { "help", "man", "TelescopePrompt", "neo-tree", "dashboard" }
					if vim.tbl_contains(ignore_ft, vim.bo[args.buf].filetype) then
						return
					end
					pcall(vim.treesitter.start, args.buf)
				end,
			})
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		branch = "main",
		event = "VeryLazy",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		config = function()
			require("nvim-treesitter-textobjects").setup({
				move = {
					set_jumps = true,
				},
			})

			local move = require("nvim-treesitter-textobjects.move")
			local map = vim.keymap.set

			map("n", "]f", function()
				move.goto_next_start("@function.outer")
			end, { desc = "Next function start" })
			map("n", "]F", function()
				move.goto_next_end("@function.outer")
			end, { desc = "Next function end" })
			map("n", "[f", function()
				move.goto_previous_start("@function.outer")
			end, { desc = "Prev function start" })
			map("n", "[F", function()
				move.goto_previous_end("@function.outer")
			end, { desc = "Prev function end" })

			-- 因此 class 导航仅保留 ]C 和 [C（class end）
			map("n", "]C", function()
				move.goto_next_end("@class.outer")
			end, { desc = "Next class end" })
			map("n", "[C", function()
				move.goto_previous_end("@class.outer")
			end, { desc = "Prev class end" })

			map("n", "]a", function()
				move.goto_next_start("@parameter.inner")
			end, { desc = "Next parameter start" })
			map("n", "]A", function()
				move.goto_next_end("@parameter.inner")
			end, { desc = "Next parameter end" })
			map("n", "[a", function()
				move.goto_previous_start("@parameter.inner")
			end, { desc = "Prev parameter start" })
			map("n", "[A", function()
				move.goto_previous_end("@parameter.inner")
			end, { desc = "Prev parameter end" })
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
}
