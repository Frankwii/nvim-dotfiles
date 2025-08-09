return {
	"stevearc/oil.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	---@module 'oil'
	---@type oil.SetupOpts
	cmds = { "Oil" },
	keys = {
		{
			"<leader>F",
			mode = "n",
			function()
				require("oil").toggle_float()
			end,
			desc = "System filetree",
		},
	},
	opts = {
		watch_for_changes = true,
		keymaps = {
			["L"] = { "actions.select", mode = "n" },
			["H"] = { "actions.parent", mode = "n" },
			["X"] = { "actions.open_external", mode = "n" },
			["T"] = { "actions.select", mode = "n", opts = { tab = true } },
			["<M-s>"] = { "actions.select" , mode = "n", opts = { vertical = true }},
			["<M-v>"] = { "actions.select" , mode = "n", opts = { horizontal = true }},
			["gp"] = { "actions.preview" , mode = "n" },
			["g?"] = { "actions.show_help", mode = "n" },
			["gs"] = { "actions.change_sort", mode = "n" },
			["g."] = { "actions.toggle_hidden", mode = "n" },
			["_"] = { "actions.open_cwd", mode = "n" },
		},
		use_default_keymaps = true,
	},
}
