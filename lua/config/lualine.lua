-- Eviline config for lualine
-- Author: shadmansaleh
-- Credit: glepnir
local lualine = require("lualine")

local colors = {
	bg = "#202328", -- Tokyo Night dark background
	fg = "#c0caf5", -- Tokyo Night light foreground
	yellow = "#e0af68", -- Tokyo Night yellow
	cyan = "#7dcfff", -- Tokyo Night cyan
	darkblue = "#2ac3de", -- Tokyo Night dark blue
	green = "#4fd6be", -- Tokyo Night green
	orange = "#ff9e64", -- Tokyo Night orange
	violet = "#bb9af7", -- Tokyo Night violet
	magenta = "#c099ff", -- Tokyo Night magenta
	blue = "#7aa2f7", -- Tokyo Night blue
	red = "#f7768e", -- Tokyo Night red
	grey = "#9a9a9a",
	wine = "#ea3680",
}

local conditions = {
	buffer_not_empty = function()
		return vim.fn.empty(vim.fn.expand("%:t")) ~= 1
	end,
	hide_in_width = function()
		return vim.fn.winwidth(0) > 80
	end,
	check_git_workspace = function()
		local filepath = vim.fn.expand("%:p:h")
		local gitdir = vim.fn.finddir(".git", filepath .. ";")
		return gitdir and #gitdir > 0 and #gitdir < #filepath
	end,
}

local config = {
	options = {
		component_separators = "",
		section_separators = "",
		theme = {
			normal = { c = { fg = colors.fg, bg = colors.bg } },
			inactive = { c = { fg = colors.fg, bg = colors.bg } },
		},
	},
	sections = {
		lualine_a = {},
		lualine_b = {},
		lualine_y = {},
		lualine_z = {},
		lualine_c = {},
		lualine_x = {},
	},
	inactive_sections = {
		lualine_a = {},
		lualine_b = {},
		lualine_y = {},
		lualine_z = {},
		lualine_c = {},
		lualine_x = {},
	},
}

local function ins_left(component)
	table.insert(config.sections.lualine_c, component)
end

local function ins_right(component)
	table.insert(config.sections.lualine_x, component)
end

ins_left({
	function()
		return "▊"
	end,
	color = function()
		local mode_color = {
			n = colors.magenta,
			i = colors.green,
			v = colors.wine,
			[""] = colors.wine,
			V = colors.wine,
			c = colors.magenta,
			no = colors.red,
			s = colors.orange,
			S = colors.orange,
			[""] = colors.orange,
			ic = colors.yellow,
			R = colors.violet,
			Rv = colors.violet,
			cv = colors.red,
			ce = colors.red,
			r = colors.cyan,
			rm = colors.cyan,
			["r?"] = colors.cyan,
			["!"] = colors.red,
			t = colors.red,
		}
		return { fg = mode_color[vim.fn.mode()] }
	end,
	padding = { left = 0, right = 1 },
})

ins_left({
	function()
		local mode_map = {
			n = "NORMAL",
			i = "INSERT",
			v = "VISUAL",
			[""] = "V-BLOCK",
			V = "V-LINE",
			c = "COMMAND",
			no = "N-OPERATOR",
			s = "SELECT",
			S = "S-LINE",
			[""] = "S-BLOCK",
			ic = "INSERT-COMPLETE",
			R = "REPLACE",
			Rv = "V-REPLACE",
			cv = "VIM EX",
			ce = "NORMAL EX",
			r = "PROMPT",
			rm = "MORE",
			["r?"] = "CONFIRM",
			["!"] = "SHELL",
			t = "TERMINAL",
		}
		return mode_map[vim.fn.mode()] or vim.fn.mode()
	end,
	color = function()
		local mode_color = {
			n = colors.magenta,
			i = colors.green,
			v = colors.wine,
			[""] = colors.wine,
			V = colors.wine,
			c = colors.magenta,
			no = colors.red,
			s = colors.orange,
			S = colors.orange,
			[""] = colors.orange,
			ic = colors.yellow,
			R = colors.violet,
			Rv = colors.violet,
			cv = colors.red,
			ce = colors.red,
			r = colors.cyan,
			rm = colors.cyan,
			["r?"] = colors.cyan,
			["!"] = colors.red,
			t = colors.red,
		}
		return { fg = mode_color[vim.fn.mode()], gui = "bold" }
	end,
	padding = { right = 1 },
})

ins_left({
	"filename",
	cond = conditions.buffer_not_empty,
	color = { fg = colors.blue, gui = "bold" },
})

ins_left({
	"diagnostics",
	sources = { "nvim_diagnostic" },
	symbols = { error = " ", warn = " ", info = " " },
	diagnostics_color = {
		error = { fg = colors.red },
		warn = { fg = colors.yellow },
		info = { fg = colors.cyan },
	},
})

ins_left({
	function()
		return "%="
	end,
})

ins_right({
	"filetype",
	icons_enabled = true,
	icon = nil,
	colored = true,
	color = { fg = colors.blue, gui = "bold" },
})

ins_right({
	"encoding",
	fmt = string.upper,
	cond = conditions.hide_in_width,
	color = { fg = colors.grey, gui = "bold" },
})

-- ins_right({
-- 	"fileformat",
-- 	fmt = string.upper,
-- 	icons_enabled = false,
-- 	color = { fg = colors.grey, gui = "bold" },
-- })

ins_right({ "location", color = { fg = colors.grey, gui = "bold" } })
ins_right({ "progress", color = { fg = colors.grey, gui = "bold" } })

ins_right({
	"branch",
	icon = "",
	color = { fg = colors.violet, gui = "bold" },
})

ins_right({
	"diff",
	symbols = { added = " ", modified = " ", removed = " " },
	diff_color = {
		added = { fg = colors.green },
		modified = { fg = colors.orange },
		removed = { fg = colors.red },
	},
	cond = conditions.hide_in_width,
})

ins_right({
	function()
		return "▊"
	end,
	color = { fg = colors.violet },
	padding = { left = 1 },
})

lualine.setup(config)
