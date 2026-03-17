return {
	"nosduco/remote-sshfs.nvim",
	dependencies = {
		"nvim-telescope/telescope.nvim",
		"nvim-lua/plenary.nvim",
	},
	keys = {
		-- 连接相关
		{ "<leader>mc", "<cmd>RemoteSSHFSConnect<cr>", desc = "Connect to remote server" },
		{ "<leader>md", "<cmd>RemoteSSHFSDisconnect<cr>", desc = "Disconnect current session" },

		-- 搜索相关（需要先连接）
		{ "<leader>mf", "<cmd>RemoteSSHFSFindFiles<cr>", desc = "Find files on remote" },
		{ "<leader>mg", "<cmd>RemoteSSHFSLiveGrep<cr>", desc = "Search content on remote" },

		-- 快捷编辑
		{ "<leader>me", "<cmd>RemoteSSHFSEdit<cr>", desc = "Edit SSH config" },
		--常规清理
		{
			"<leader>mx",
			function()
				local ok = pcall(vim.cmd, "RemoteSSHFSDisconnect")
				if not ok then
					vim.notify("Force cleaning remote connection...", vim.log.levels.WARN)
					local mounts_dir = vim.fn.expand("$HOME") .. "/.sshfs/"

					-- 只清理当前 Neovim 进程的挂载（通过 PID 过滤）
					local pid = vim.fn.getpid()
					os.execute(
						string.format(
							"fusermount -uz $(mount | grep '%s' | grep '%d' | awk '{print $3}') 2>/dev/null",
							mounts_dir,
							pid
						)
					)

					pcall(require("remote-sshfs").setup)
					vim.notify("Force cleaned current connection", vim.log.levels.INFO)
				end
			end,
			desc = "Emergency disconnect",
		},
		{
			"<leader>mX", -- 紧急退出
			function()
				local ok = pcall(vim.cmd, "RemoteSSHFSDisconnect")
				if not ok then
					vim.notify("Force cleaning remote connections...", vim.log.levels.WARN)
					local mounts_dir = vim.fn.expand("$HOME") .. "/.sshfs/"
					os.execute("fusermount -uz " .. mounts_dir .. "* 2>/dev/null")
					os.execute("rmdir " .. mounts_dir .. "* 2>/dev/null")
					pcall(require("remote-sshfs").setup)
					vim.notify("Force cleaned all connections", vim.log.levels.INFO)
				end
			end,
			desc = "Emergency disconnect",
		},
	},
	-- 插件配置
	opts = {
		-- 连接配置
		connections = {
			-- 从 SSH 配置文件读取主机列表
			ssh_configs = {
				vim.fn.expand("$HOME") .. "/.ssh/config",
				"/etc/ssh/ssh_config",
			},
			-- sshfs 额外参数
			sshfs_args = {
				"-o reconnect", -- 断线重连
				"-o ConnectTimeout=5", -- 连接超时 5 秒
				"-o ServerAliveInterval=15", -- 保活间隔 15 秒
				"-o idmap=user", -- 用户 ID 映射，避免权限问题
			},
		},
		mounts = {
			-- 本地挂载点根
			base_dir = vim.fn.expand("$HOME") .. "/.sshfs/",
			-- 退出 Neovim 时自动卸载
			unmount_on_exit = true,
			-- 添加错误恢复选项
			force_unmount = true,
			unmount_timeout = 5000,
		},
		handlers = {
			on_connect = {
				-- 连接后自动切换到挂载目录
				change_dir = true,
			},
			on_disconnect = {
				-- 断开后清理挂载目录
				clean_mount_folders = true,
			},
		},
		ui = {
			confirm = {
				-- 连接前是否确认
				connect = false, -- 设为 false 减少确认步骤
			},
		},
	},
	init = function()
		-- 创建挂载点根目录（如果不存在
		local mounts_dir = vim.fn.expand("$HOME") .. "/.sshfs"
		if vim.fn.isdirectory(mounts_dir) == 0 then
			vim.fn.mkdir(mounts_dir, "p")
		end
	end,
	config = function(_, opts)
		-- 先执行 remote-sshfs 的 setup
		require("remote-sshfs").setup(opts)

		-- 然后加载 Telescope 扩展
		local telescope_ok, telescope = pcall(require, "telescope")
		if telescope_ok then
			telescope.load_extension("remote-sshfs")
		end
	end,
}
