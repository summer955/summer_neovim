local function setup_diagnostics()
	-- 图标定义
	local error_icon = ""
	local warn_icon = ""
	local info_icon = ""
	local hint_icon = ""

	vim.diagnostic.config({
		underline = true,
		update_in_insert = false,
		virtual_text = {
			spacing = 2,
			source = "if_many",
			prefix = "•",

			format = function(diagnostic)
				local msg = diagnostic.message
				msg = msg:gsub("\n", " ")
				msg = msg:gsub("%s+", " ")

				-- 简化常见消息
				local simplifications = {
					["cannot be resolved"] = "unresolved",
					["The method .- is undefined"] = "undefined method",
					["The value .- is not"] = "not",
					["is never used"] = "unused",
					["is never read"] = "unread",
				}

				for pattern, replacement in pairs(simplifications) do
					msg = msg:gsub(pattern, replacement)
				end

				-- 限制长度
				if #msg > 80 then
					msg = msg:sub(1, 57) .. "..."
				end

				return msg
			end,

			-- 只显示错误和警告
			severity = {
				min = vim.diagnostic.severity.WARN,
			},
		},

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

	-- 美化其他 LSP 浮动窗口
	local border_opts = { border = "rounded" }

	vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, border_opts)

	vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, border_opts)
end

setup_diagnostics()
