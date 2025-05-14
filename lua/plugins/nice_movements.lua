return {
	{
		"folke/flash.nvim",
		keys = { "f", "F", "t", "T" },
		opts = {
			modes = {
				search = { enabled = false },
				char = {
					enabled = true,
					autohide = true,
					jump_labels = true,
					highlights = { backdrop = true },
					keys = { "f", "F", "t", "T" },
				},
			},
		},
	},
}
