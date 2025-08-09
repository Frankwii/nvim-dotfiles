return {
	"Wansmer/treesj",
	keys = {
		{
	     "H",
	     function() require("treesj").join() end,
	     mode = "n",
	     desc = "Treesj collapse",
	   },
		{
			"L",
			function()
				require("treesj").split()
			end,
			mode = "n",
			desc = "Treesj expand",
		},
	},
	dependencies = { "nvim-treesitter/nvim-treesitter" },
	 opts = {
	   use_default_keymaps = false,
	   max_join_length = 150,
	 }
}
