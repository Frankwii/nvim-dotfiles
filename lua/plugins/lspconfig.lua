return {
	{
		"neovim/nvim-lspconfig",
		init = function()
			require("mappings.lsp")
		end,
		event = { "BufReadPre", "BufNewFile" },
		dependencies = { "saghen/blink.cmp" },
	},
	{ "saghen/blink.compat", lazy = false },
	{ -- optional blink completion source for require statements and module annotations
		"saghen/blink.cmp",
		build = "cargo build --release",
		version = "1.*",
		dependencies = {
			{ "saghen/blink.compat" },
			{ "micangl/cmp-vimtex" },
			{ "mikavilpas/blink-ripgrep.nvim" },
		},
		opts = {
			keymap = {
				preset = "none",
				["<C-j>"] = { "select_next", "fallback" },
				["<C-k>"] = { "select_prev", "fallback" },
				["<C-l>"] = { "accept", "snippet_forward", "fallback" },
				["<C-Space>"] = { "select_and_accept", "fallback" },
				["<C-s>"] = { "show_signature", "hide_signature", "fallback" },
				["<CR>"] = { "accept", "fallback" },

				-- ["H"] = { "hide", "snippet_backward", "fallback" },
				-- ["K"] = { "show_documentation", "hide_documentation", "fallback" },
				["<C-d>"] = { "scroll_documentation_down", "fallback" },
				["<C-u>"] = { "scroll_documentation_up", "fallback" },
				["<Tab>"] = { "select_next", "fallback" },
				["<S-Tab>"] = { "select_prev", "fallback" },
			},
			sources = {
				-- add lazydev to your completion providers
				default = {
					"lazydev",
					"vimtex",
					"lsp",
					"snippets",
					"path",
					"buffer",
					"ripgrep",
				},
				providers = {
					lazydev = {
						name = "LazyDev",
						module = "lazydev.integrations.blink",
						-- make lazydev completions top priority (see `:h blink.cmp`)
						score_offset = 100,
					},
					vimtex = {
						name = "vimtex",
						module = "blink.compat.source",
					},
					snippets = {
						score_offset = 120,
					},
					ripgrep = {
            score_offset = -10,
						name = "Ripgrep",
						module = "blink-ripgrep",
						---@module "blink-ripgrep"
						---@type blink-ripgrep.Options
						opts = {
							project_root_marker = { ".git", ".jj", "pyproject.toml" },
							backend = {
								ripgrep = { ignore_paths = { "~" } },
							},
						},
					},
				},
			},
			snippets = { preset = "luasnip" },
			cmdline = { enabled = false },
			signature = {
				enabled = true,
				window = {
					border = { "╔", "═", "╗", "║", "╝", "═", "╚", "║" },
				},
			},

			completion = {
				-- Disable auto brackets
				accept = { auto_brackets = { enabled = false } },
				-- Don't select by default, auto insert on selection
				list = { selection = { preselect = false, auto_insert = true } },
				menu = {
					border = { "╔", "═", "╗", "║", "╝", "═", "╚", "║" },
				},
				documentation = {
					auto_show = true,
					window = {
						border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
					},
				},
			},
		},
	},
}
