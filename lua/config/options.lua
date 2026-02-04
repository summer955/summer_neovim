local opt = vim.opt
local g = vim.g
local wo = vim.wo

-- 缩进与制表符设置
opt.tabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.smartindent = true
opt.autoindent = true

-- 基本设置
opt.mouse = "a" -- 启用鼠标
opt.clipboard = "unnamedplus" -- 系统剪贴板
opt.swapfile = false -- 不使用交换文件
opt.undofile = true -- 启用撤销持久化

-- 真彩色
opt.termguicolors = true

-- 禁用自带的文件树
-- g.loaded_netrw = 1
-- g.loaded_netrwPlugin = 1
-- 在 init.lua 的最开头添加
g.loaded_2html_plugin = 1 -- 禁用 2html
g.loaded_tutor_mode_plugin = 1 -- 禁用 tutor
g.loaded_rrhelper = 1 -- 禁用 rrhelper

-- vim.opt.fillchars = {
-- 	horiz = "─",
-- 	horizup = "┴",
-- 	horizdown = "┬",
-- 	vert = "│",
-- 	vertleft = "┤",
-- 	vertright = "├",
-- 	verthoriz = "┼",
-- }
vim.opt.fillchars = {
	horiz = "━", -- 粗水平线
	horizup = "┻", -- 粗上T型
	horizdown = "┳", -- 粗下T型
	vert = "┃", -- 粗垂直线
	vertleft = "┫", -- 粗左T型
	vertright = "┣", -- 粗右T型
	verthoriz = "╋", -- 粗十字
	eob = " ", -- 隐藏波浪线
}

-- 根据主题自动调整
vim.api.nvim_create_autocmd("ColorScheme", {
	pattern = "*",
	callback = function()
		vim.api.nvim_set_hl(0, "WinSeparator", {
			fg = vim.api.nvim_get_hl_by_name("Comment", true).foreground or "#5c6370",
			bg = "NONE",
		})
	end,
})
