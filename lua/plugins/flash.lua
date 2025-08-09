return {
	{
		"folke/flash.nvim",
		keys = {
      -- "f",
      -- "F",
      -- "t",
      -- "T",
      "/",
      "?",
      { "P", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
    },
		opts = {
      jump = {
        autojump = true
      },
			modes = {
				search = { enabled = true },
				char = {
					enabled = false,
					autohide = true,
					jump_labels = true,
					highlights = { backdrop = true },
					keys = { "f", "F", "t", "T" },
				},
			},
		},
	},
}
