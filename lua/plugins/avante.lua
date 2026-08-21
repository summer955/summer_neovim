local function select_acp_option(category, prompt)
	local avante = require("avante")
	local sidebar = avante.get(false)
	if not sidebar or not sidebar:is_open() then require("avante.api").ask({ new_chat = true, without_selection = true }) end
	sidebar = avante.get(false)

	local function show_selector()
		local client = sidebar.acp_client
		local session_id = sidebar.chat_history and sidebar.chat_history.acp_session_id
		if not client or not session_id or not client.config_options then return end

		local labels, choices = {}, {}
		for _, option in ipairs(client.config_options) do
			if option.category == category and option.options then
				for _, value in ipairs(option.options) do
					local prefix = value.value == option.currentValue and "* " or "  "
					table.insert(labels, prefix .. value.name)
					table.insert(choices, { config_id = option.id, value = value.value })
				end
			end
		end
		if #choices == 0 then
			vim.notify("No " .. prompt .. " options are available", vim.log.levels.WARN)
			return
		end

		vim.ui.select(labels, { prompt = prompt .. "> " }, function(_, index)
			if not index then return end
			local choice = choices[index]
			client:set_config_option(session_id, choice.config_id, choice.value, function(_, err)
				if err then vim.notify(err.message or "Failed to update " .. prompt, vim.log.levels.ERROR) end
			end)
		end)
	end

	if sidebar.acp_client and sidebar.acp_client.config_options then
		show_selector()
		return
	end

	sidebar:handle_submit("")
	local attempts = 0
	local timer = vim.uv.new_timer()
	if not timer then return end
	timer:start(
		200,
		200,
		vim.schedule_wrap(function()
			attempts = attempts + 1
			if sidebar.acp_client and sidebar.acp_client.config_options then
				timer:stop()
				timer:close()
				show_selector()
			elseif attempts >= 50 then
				timer:stop()
				timer:close()
				vim.notify("Timed out waiting for Codex ACP", vim.log.levels.ERROR)
			end
		end)
	)
end

return {
	"yetone/avante.nvim",
	build = vim.fn.has("win32") ~= 0 and "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false"
		or "make",
	event = "VeryLazy",
	opts = {
		provider = "codex",
		acp_providers = {
			codex = {
				command = "codex-acp",
				args = {},
				env = {
					NODE_NO_WARNINGS = "1",
					HOME = os.getenv("HOME"),
					PATH = os.getenv("PATH"),
					OPENAI_API_KEY = os.getenv("OPENAI_API_KEY"),
					CODEX_PATH = vim.fn.exepath("codex"),
					APP_SERVER_LOGS = vim.fn.stdpath("state") .. "/codex-acp",
				},
			},
		},
		-- Traditional Responses API fallback. Codex ACP is the active provider.
		--[[
		providers = {
			openai_relay = {
				__inherited_from = "openai",
				endpoint = "https://sub.ns.tisoz.com/v1",
				model = "gpt-5.6-luna",
				api_key_name = "OPENAI_API_KEY",
				use_response_api = true,
				support_previous_response_id = true,
				disable_tools = true,
				disabled_tools = { "attempt_completion" },
				timeout = 120000,
				extra_request_body = {
					max_completion_tokens = 16384,
					reasoning_effort = "xhigh",
					store = false,
				},
			},
		},
		--]]
		selection = {
			hint_display = "none",
		},
		behaviour = {
			auto_set_keymaps = false,
		},
	},
	cmd = {
		"AvanteAsk",
		"AvanteACPModes",
		"AvanteACPModels",
		"AvanteBuild",
		"AvanteChat",
		"AvanteClear",
		"AvanteEdit",
		"AvanteFocus",
		"AvanteHistory",
		"AvanteModels",
		"AvanteRefresh",
		"AvanteShowRepoMap",
		"AvanteStop",
		"AvanteSwitchProvider",
		"AvanteToggle",
	},
	keys = {
		{ "<leader>aa", "<cmd>AvanteAsk<CR>", desc = "Ask Avante" },
		{ "<leader>ac", "<cmd>AvanteChat<CR>", desc = "Chat with Avante" },
		{ "<leader>ae", "<cmd>AvanteEdit<CR>", desc = "Edit Avante" },
		{ "<leader>af", "<cmd>AvanteFocus<CR>", desc = "Focus Avante" },
		{ "<leader>ah", "<cmd>AvanteHistory<CR>", desc = "Avante History" },
		{
			"<leader>am",
			function() select_acp_option("model", "Codex Model") end,
			desc = "Select Codex Model",
		},
		{
			"<leader>aM",
			function() select_acp_option("mode", "Codex Mode") end,
			desc = "Select Codex Mode",
		},
		{
			"<leader>aR",
			function() select_acp_option("thought_level", "Reasoning Effort") end,
			desc = "Select Codex Reasoning Effort",
		},
		{ "<leader>an", "<cmd>AvanteChatNew<CR>", desc = "New Avante Chat" },
		{ "<leader>ap", "<cmd>AvanteSwitchProvider<CR>", desc = "Switch Avante Provider" },
		{ "<leader>ar", "<cmd>AvanteRefresh<CR>", desc = "Refresh Avante" },
		{ "<leader>as", "<cmd>AvanteStop<CR>", desc = "Stop Avante" },
		{ "<leader>at", "<cmd>AvanteToggle<CR>", desc = "Toggle Avante" },
	},
}
