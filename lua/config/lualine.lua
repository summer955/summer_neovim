-- Eviline config for lualine
-- Author: shadmansaleh
-- Credit: glepnir
local lualine = require("lualine")

local colors = {
	bg = "#202328",
	fg = "#c0caf5",
	yellow = "#e0af68",
	cyan = "#7dcfff",
	darkblue = "#2ac3de",
	green = "#4fd6be",
	orange = "#ff9e64",
	violet = "#bb9af7",
	magenta = "#c099ff",
	blue = "#7aa2f7",
	red = "#f7768e",
	grey = "#9a9a9a",
	wine = "#ea3680",
	azure = "#00afd7",
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
		disabled_filetypes = {
			statusline = { "dashboard", "snacks_dashboard" },
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
			c = colors.azure,
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
	padding = { right = 1 },
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
			c = colors.azure,
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
	icon = "󰕷",
	padding = { right = 1 },
})

-- filename
ins_left({
	function()
		local path = vim.fn.expand("%") -- 相对路径
		if path == "" then
			return ""
		end

		-- 保留你的图标获取逻辑（完全不变）
		local ft = vim.bo.filetype
		local icon, _ = require("nvim-web-devicons").get_icon_by_filetype(ft)
		icon = icon or ""

		-- 智能压缩路径函数（只处理路径部分）
		local function compress_path(full_path)
			local parts = {}
			for part in string.gmatch(full_path, "([^/]+)") do
				table.insert(parts, part)
			end

			-- 如果只有1-3级，直接显示完整路径
			if #parts <= 3 then
				return table.concat(parts, "/")
			end

			-- 压缩中间部分：保留第一级和最后两级
			-- 例如：nvim/lua/config/example.lua → nvim/.../config/example.lua
			local compressed = {
				parts[1], -- 第一级: nvim
				"…", -- 省略号
				parts[#parts - 1], -- 父目录: config
				parts[#parts], -- 文件名: example.lua
			}

			return table.concat(compressed, "/")
		end

		-- 返回格式："图标 压缩后的路径"
		return icon .. " " .. compress_path(path)
	end,
	cond = conditions.buffer_not_empty,
	color = { fg = colors.grey, gui = "italic" },
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
	function()
		if not (package.loaded["noice"] and require("noice").api.status.command.has()) then
			return ""
		end
		local cmd = require("noice").api.status.command.get()

		-- 根据命令类型加不同图标
		if cmd:sub(1, 1) == ":" then
			return "󰹬 " .. "CMD" -- 命令行图标
		elseif cmd:sub(1, 1) == "/" then
			return "󰈞 " .. cmd -- 向前搜索图标
		elseif cmd:sub(1, 1) == "?" then
			return "󰈝 " .. cmd -- 向后搜索图标
		end
		return "󰞉 " .. cmd
	end,
	color = { fg = colors.grey, gui = "bold" },
	padding = { right = 1 },
})

-- ins_right({
-- 	"encoding",
-- 	fmt = string.upper,
-- 	icon = "󰧮",
-- 	cond = conditions.hide_in_width,
-- 	color = { fg = colors.grey, gui = "bold" },
-- })

ins_right({
	"fileformat",
	fmt = string.upper,
	icons = {
		unix = "", -- LF
		dos = "", -- CRLF
		mac = "", -- CR
	},
	color = { fg = colors.grey, gui = "bold" },
})

-- location
-- ins_right({ "location", color = { fg = colors.grey, gui = "bold" } })
ins_right({
	function()
		local line = vim.fn.line(".")
		local col = vim.fn.virtcol(".")
		return " " .. line .. ":" .. col
	end,
	color = { fg = colors.grey, gui = "bold" },
})

-- progress
-- ins_right({ "progress", color = { fg = colors.grey, gui = "bold" } })
ins_right({
	function()
		local current_line = vim.fn.line(".")
		local total_lines = vim.fn.line("$")

		if current_line == 1 then
			return "󰉢 Top"
		end

		if current_line == total_lines then
			return "󰉢 Bot"
		end

		local percentage = math.floor((current_line / total_lines) * 100)
		return "󰉢 " .. percentage .. "%%"
	end,
	color = { fg = colors.grey, gui = "bold" },
})

--filetype
ins_right({
	"filetype",
	icons_enabled = true,
	icon = nil,
	colored = true,
	color = { fg = colors.blue, gui = "bold" },
})

-- git diff
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
-- git branch
ins_right({
	"branch",
	icon = "",
	color = { fg = colors.violet, gui = "bold" },
})

ins_right({
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
			c = colors.azure,
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
	padding = { left = 0 },
})

lualine.setup(config)
