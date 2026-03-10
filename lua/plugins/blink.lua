return {
	"saghen/blink.cmp",
	event = { "InsertEnter", "CmdlineEnter" },
	dependencies = {
		"onsails/lspkind-nvim", -- 美化图标
		"rafamadriz/friendly-snippets",
		{ "L3MON4D3/LuaSnip", version = "v2.*" },
	},
	version = "1.*",
	opts = {
		snippets = {
			preset = "luasnip",
		},

		appearance = {
			use_nvim_cmp_as_default = false,
			nerd_font_variant = "mono",
		},

		completion = {
			list = {
				selection = {
					preselect = false, -- 不自动预选第一项
				},
			},
			accept = {
				auto_brackets = {
					enabled = true,
				},
			},
			menu = {
				border = "rounded",
				winblend = 10,
				max_height = 15,
				draw = {
					treesitter = { "lsp" },
					columns = {
						{ "label", "label_description", gap = 1 },
						{ "kind_icon", "kind", gap = 1 },
						{ "source_name" },
					},
					components = {
						kind_icon = {
							text = function(ctx)
								-- 使用 lspkind 生成图标
								local lspkind = require("lspkind")
								return lspkind.symbol_map[ctx.kind] or ctx.kind_icon
							end,
							highlight = function(ctx)
								return { group = ctx.kind_hl }
							end,
						},
						source_name = {
							highlight = "Comment",
						},
					},
				},
			},
			documentation = {
				auto_show = true,
				auto_show_delay_ms = 200,
			},
			ghost_text = {
				enabled = true, -- 安全处理
			},
		},

		-- 如果想启用签名帮助，取消下面的注释
		signature = { enabled = true },

		sources = {
			-- compat = {}, -- 如果需要使用 nvim-cmp 的源
			default = { "lsp", "path", "snippets", "buffer" },
			providers = {
				snippets = {
					name = "LuaSnip",
					--
					module = "blink.cmp.sources.snippets",
					score_offset = -1,
					opts = {
						--For `snippets.preset == 'luasnip'`
						use_show_condition = true,
						-- Whether to show autosnippets in the completion list
						show_autosnippets = true,
						-- Whether to prefer docTrig placeholders over trig when expanding regTrig snippets
						prefer_doc_trig = false,
						-- Whether to put the snippet description in the label description
						use_label_description = false,
					},
				},
			},
		},

		cmdline = {
			enabled = true,
			keymap = {
				preset = "cmdline",
			},
			sources = { "buffer", "cmdline" },
			completion = {
				menu = {
					auto_show = function(ctx)
						return vim.fn.getcmdtype() == ":"
					end,
				},
				list = {
					selection = {
						preselect = false,
						auto_insert = true,
					},
				},
				ghost_text = { enabled = true },
			},
		},

		keymap = {
			preset = "none",
			["<Tab>"] = { "select_next", "snippet_forward", "fallback" },
			["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" },
			["<CR>"] = { "select_and_accept", "fallback" },
		},
	},
}
