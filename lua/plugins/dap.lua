return {
	{
		"jay-babu/mason-nvim-dap.nvim",
		dependencies = "williamboman/mason.nvim",
		event = "VeryLazy",
		config = function()
			require("mason-nvim-dap").setup({
				ensure_installed = {
					"codelldb", -- C/C++/Rust
					"python", --debugpy
					-- "bash-debug-adapter",
					-- "chrome",
					-- "firefox",
				},
				handlers = {
					python = function(config)
						-- 覆盖默认的 adapters 配置（使用 Mason 安装的 debugpy）
						config.adapters = {
							type = "executable",
							command = vim.fn.stdpath("data") .. "/mason/packages/debugpy/venv/bin/python",
							args = { "-m", "debugpy.adapter" },
						}

						-- 可选：自定义 configurations（否则会使用 nvim-dap 的全局配置）
						config.configurations = {
							{
								type = "python",
								request = "launch",
								name = "Launch with Mason debugpy",
								program = "${file}",
							},
						}

						require("mason-nvim-dap").default_setup(config) -- 必须调用！
					end,

					codelldb = function(config)
						-- 直接使用默认适配器（假设 mason-nvim-dap 已注册）
						config.configurations = {
							{
								name = "Launch file",
								type = "codelldb", -- 必须与 mason-nvim-dap 注册的名称致
								request = "launch",
								program = function()
									-- 提示用户输入可执行文件路径（默认当前目录）
									return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
								end,
								cwd = "${workspaceFolder}",
							},
						}
						require("mason-nvim-dap").default_setup(config)
					end,
				},
			})
		end,
	},
	{
		"mfussenegger/nvim-dap",
		event = "VeryLazy",
		dependencies = {
			"theHamsta/nvim-dap-virtual-text",
		},
		keys = {
			{
				"<leader>dB",
				function()
					require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))
				end,
				desc = "Breakpoint Condition",
			},
			{
				"<leader>db",
				function()
					require("dap").toggle_breakpoint()
				end,
				desc = "Toggle Breakpoint",
			},
			{
				"<leader>dc",
				function()
					require("dap").continue()
				end,
				desc = "Continue",
			},
			{
				"<leader>da",
				function()
					require("dap").continue({})
				end,
				desc = "Run with Args",
			},
			{
				"<leader>dC",
				function()
					require("dap").run_to_cursor()
				end,
				desc = "Run to Cursor",
			},
			{
				"<leader>dg",
				function()
					require("dap").goto_()
				end,
				desc = "Go to Line (No Execute)",
			},
			{
				"<leader>di",
				function()
					require("dap").step_into()
				end,
				desc = "Step Into",
			},
			{
				"<leader>dj",
				function()
					require("dap").down()
				end,
				desc = "Down",
			},
			{
				"<leader>dk",
				function()
					require("dap").up()
				end,
				desc = "Up",
			},
			{
				"<leader>dl",
				function()
					require("dap").run_last()
				end,
				desc = "Run Last",
			},
			{
				"<leader>do",
				function()
					require("dap").step_out()
				end,
				desc = "Step Out",
			},
			{
				"<leader>dO",
				function()
					require("dap").step_over()
				end,
				desc = "Step Over",
			},
			{
				"<leader>dp",
				function()
					require("dap").pause()
				end,
				desc = "Pause",
			},
			{
				"<leader>dr",
				function()
					require("dap").repl.toggle()
				end,
				desc = "Toggle REPL",
			},
			{
				"<leader>ds",
				function()
					require("dap").session()
				end,
				desc = "Session",
			},
			{
				"<leader>dt",
				function()
					require("dap").terminate()
				end,
				desc = "Terminate",
			},
			{
				"<leader>dw",
				function()
					require("dap.ui.widgets").hover()
				end,
				desc = "Widgets",
			},
		},
		-- config = function()
		-- 	require("config.debuggers")
		-- end,
	},

	{
		"rcarriga/nvim-dap-ui",
		dependencies = { "nvim-neotest/nvim-nio", "mfussenegger/nvim-dap" },
		keys = {
			{
				"<leader>du",
				function()
					require("dapui").toggle({})
				end,
				desc = "Dap UI",
			},
			{
				"<leader>de",
				function()
					require("dapui").eval()
				end,
				desc = "Eval",
				mode = { "n", "v" },
			},
		},
		opts = {},
		config = function(_, opts)
			-- setup dap config by VsCode launch.json file
			-- require("dap.ext.vscode").load_launchjs()
			local dap = require("dap")
			local dapui = require("dapui")
			dapui.setup(opts)
			dap.listeners.after.event_initialized["dapui_config"] = function()
				dapui.open({})
			end
			dap.listeners.before.event_terminated["dapui_config"] = function()
				dapui.close({})
			end
			dap.listeners.before.event_exited["dapui_config"] = function()
				dapui.close({})
			end
		end,
	},
	-- {
	-- 	"theHamsta/nvim-dap-virtual-text",
	-- 	event = "BufEnter *.c,*.cpp,*.py",
	-- 	opts = {},
	-- },
}
