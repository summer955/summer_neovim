local function setup_diagnostics()
	-- 图标定义
	local error_icon = ""
	local warn_icon = ""
	local info_icon = ""
	local hint_icon = ""

	vim.diagnostic.config({
		underline = true,
		update_in_insert = false,
		-- 注意：virtual_text 已由插件 tiny-inline-diagnostic 管理
		severity_sort = true,

		-- 侧边栏图标
		signs = {
			text = {
				[vim.diagnostic.severity.ERROR] = error_icon,
				[vim.diagnostic.severity.WARN] = warn_icon,
				[vim.diagnostic.severity.HINT] = hint_icon,
				[vim.diagnostic.severity.INFO] = info_icon,
			},
		},

		-- 浮动窗口
		float = {
			border = "rounded",
			source = "always", -- 总是显示来源
			format = function(diagnostic)
				local source = diagnostic.source or "unknown"
				local msg = diagnostic.message:gsub("\n", " ")
				return string.format("%s\n[%s]", msg, source)
			end,
		},
	})
end

setup_diagnostics()
