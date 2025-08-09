return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	---@type snacks.Config
	keys = {
		{
			"<leader>z",
			function()
        require("snacks").zen()
      end,
			desc = "Zen mode",
		},
		{
			"<leader>H",
			function()
        require("snacks").dashboard()
      end,
			desc = "Home dashboard",
		},
	},
	opts = {
		dashboard = {
			enabled = true,
			preset = {
				keys = {
					{ icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
					{ icon = " ", key = "r", desc = "Recent Files", action = ":lua Snacks.dashboard.pick('oldfiles')" },
					{ icon = " ", key = "s", desc = "Restore Session", section = "session" },
					{ icon = "󰒲 ", key = "L", desc = "Lazy", action = ":Lazy", enabled = package.loaded.lazy ~= nil },
					{ icon = "󱪨 ", key = "n", desc = "Neorg", action = ":Neorg index" },
					{ icon = "󰺿 ", key = "J", desc = "Journal", action = ":Neorg journal today" },
					{ icon = " ", key = "q", desc = "Quit", action = ":qa" },
				},
			},
		},
		dim = {
			animate = { enabled = false },
		},
		indent = {
			priority = 1,
			enabled = true,
			only_current = true,
			animate = { enabled = false },
		},
		zen = {
			animate = { enabled = false },
		},
	},
}
