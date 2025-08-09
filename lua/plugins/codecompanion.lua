return {
	"olimorris/codecompanion.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-treesitter/nvim-treesitter",
	},
	cmd = {
		"CodeCompanion",
		"CodeCompanionActions",
		"CodeCompanionChat",
		"CodeCompanionCmd",
	},
  keys = {
    {"<leader>Ac", ":CodeCompanionChat Toggle<CR>", mode={"n"}, desc="Chat"}
  },
	opts = {
		adapters = {
			gemini = function()
				return require("codecompanion.adapters").extend("gemini", {
					env = {
						api_key = "cmd: cat ~/.keys/gemini",
					},
				})
			end,
		},
		strategies = {
			chat = {
				adapter = "gemini",
				model = "gemini-2.5-pro",
				keymaps = {
					send = {
						modes = {
							n = "<C-CR>",
						},
						opts = { desc = "Send prompt to LLM" },
					},
					close = {
						n = "<C-c>",
						opts = { desc = "Close codecompanion chat window" },
					},
				},
			},
		},
		display = {
			action_palette = {
				provider = "telescope",
			},
			chat = {
				icons = {
					buffer_pin   = " ",
					buffer_watch = "󰂥 ",
					chat_context = " ",
					tool_success = " ",
					tool_failure = " ",
				},
				window = {
					layout = "vertical",
					position = "right",
					width = 0.3,
				},
	       auto_scroll = false,
	       intro_message = "LLM Chat. Press ? to see mappings.",
	       show_settings = true,
	       show_tools_processing = true,
	       show_token_count = true,
	       start_in_insert_mode = false
			},
		},
	},
}
