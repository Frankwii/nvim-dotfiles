return {
	"svban/YankAssassin.nvim",
	keys = {
    "y",
		-- { "y", "<Plug>(YANoMove)", silent = true, mode = { "x", "n" } },
		{ "gy", "<Plug>(YADefault)", silent = true, mode = { "x", "n" } },
	},
	opts = {
		auto_normal = true, -- if true, autocmds are used. Whenever y is used in normal mode, the cursor doesn't move to start
		auto_visual = true, -- if true, autocmds are used. Whenever y is used in visual mode, the cursor doesn't move to start
	},
}
