require("nvim-treesitter.configs").setup({
	auto_install = true,

	ensure_installed = {
		"bash",
		"c",
		"cpp",
		"css",
		"dockerfile",
		"go",
		"html",
		"java",
		"javascript",
		"json",
		"lua",
		"markdown",
		"markdown_inline",
		"python",
		"regex",
		"rust",
		"sql",
		"toml",
		"tsx",
		"typescript",
		"vim",
		"vimdoc",
		"yaml",
	},
	sync_install = false,
	indent = {
		enable = true,
		disable = { "yaml", "html", "markdown" },
	},
	ignore_install = {},
	highlight = {
		enable = true,
		disable = function(lang, buf)
			local max_filesize = 100 * 1024
			local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
			if ok and stats and stats.size > max_filesize then
				return true
			end
		end,
		additional_vim_regex_highlighting = false,
	},
	locals = { enable = true },
	incremental_selection = {
		enable = true,
		keymaps = {
			init_selection = "<C-space>",
			node_incremental = "<C-space>",
			scope_incremental = false,
			node_decremental = "<bs>",
		},
	},

	textobjects = {
		move = {
			enable = true,
			goto_next_start = { ["]f"] = "@function.outer", ["]c"] = "@class.outer" },
			goto_next_end = { ["]F"] = "@function.outer", ["]C"] = "@class.outer" },
			goto_previous_start = { ["[f"] = "@function.outer", ["[c"] = "@class.outer" },
			goto_previous_end = { ["[F"] = "@function.outer", ["[C"] = "@class.outer" },
		},
	},
})
