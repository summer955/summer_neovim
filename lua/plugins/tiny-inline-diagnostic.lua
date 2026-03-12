return {
	"rachartier/tiny-inline-diagnostic.nvim",
	event = "LspAttach",
	config = function()
		require("tiny-inline-diagnostic").setup({
			preset = "modern",
			transparent_bg = false,
			transparent_cursorline = true,
			options = {
				show_source = {
					enabled = true, -- 显示诊断来源
				},
				-- 自定义显示消息的来源
				format = function(diag)
					return diag.message .. " [" .. diag.source .. "]"
				end,
				multilines = {
					enabled = true,
					always_show = false,
					enable_on_select = true,
				},
				use_icons_from_diagnostic = true,
				-- add_messages = {
				--     display_count = true,
				-- },
				throttle = 20, -- 性能优化
				multiple_diag_behavior = "each", -- 多诊断显示方式
				virt_texts = {
					priority = 2048, -- 虚拟文本的显示优先级
				},
			},
		})

		-- 关闭 Neovim 默认的诊断文本显示，避免冲突
		vim.diagnostic.config({ virtual_text = false })
	end,
}
