return {
	"stevearc/conform.nvim",
	keys = {
		{
			"<leader>F",
			function()
				require("conform").format()
			end,
			mode = { "n", "v" },
			desc = "Format buffer",
		},
	},
	opts = {
		formatters_by_ft = {
			lua = { "stylua" },
			python = { "ruff_format", "ruff_organize_imports" },
		},
		default_format_opts = {
			lsp_format = "fallback",
		},
		-- format_on_save = {
		--   lsp_format = "fallback",
		--   timeout_ms = 500
		-- }
	},
}
