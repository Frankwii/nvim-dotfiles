return {
	{
		"folke/flash.nvim",
		keys = {
			"f",
			"F",
			"t",
			"T",
      "/",
      "?",
			{
				"P",
				mode = { "n", "x", "o" },
				function()
					require("flash").jump()
				end,
				desc = "Flash",
			},
			-- {
			-- 	"R",
			-- 	mode = "o",
			-- 	function()
			-- 		require("flash").remote()
			-- 	end,
			-- 	desc = "Remote Flash",
			-- },
			-- {
			-- 	"gr",
			-- 	mode = { "n", "x", "o" },
			-- 	function()
			-- 		require("flash").treesitter()
			-- 	end,
			-- 	desc = "Flash Treesitter",
			-- },
			-- {
			-- 	"gR",
			-- 	mode = { "o", "x" },
			-- 	function()
			-- 		require("flash").treesitter_search()
			-- 	end,
			-- 	desc = "Treesitter Search",
			-- },
			-- {
			-- 	"<c-p>",
			-- 	mode = { "c" },
			-- 	function()
			-- 		require("flash").toggle()
			-- 	end,
			-- 	desc = "Toggle Flash Search",
			-- },
		},
		opts = {
			modes = {
				search = { enabled = true },
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
