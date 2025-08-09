return {
	"stevearc/quicker.nvim",
	event = "FileType qf",
	---@module "quicker"
	---@type quicker.SetupOptions
	keys = {
		{
			"<C-q><C-q>",
			function()
				require("quicker").toggle({ focus = true })
			end,
			mode = { "n", "x" },
			desc = "Toggle quickfix list",
		},
	},
	opts = {
		use_default_opts = false,
		edit = {
			enabled = false,
		},
		keys = {
			{
				">",
				function()
					require("quicker").expand()
				end,
				mode = "n",
				desc = "Expand quickfix content",
			},
			{
				"<",
				function()
					require("quicker").collapse()
				end,
				mode = "n",
				desc = "Expand quickfix content",
			},
			-- {
			-- 	"<CR>",
			-- 	"<CR>:cclose<CR>",
			-- 	noremap = true,
			-- 	mode = "n",
			-- 	desc = "Open entry and close quickfix list.",
			-- },
		},
		follow = {
			enabled = true,
		},
		opts = {
			relativenumber = false,
			wrap = true,
		},
	},
}
