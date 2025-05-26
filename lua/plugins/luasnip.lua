return {
	{
		"L3MON4D3/LuaSnip",
    event = "VeryLazy",
		init = function()
			vim.g.lua_snippets_path = "./lua/snippets/lua"
			vim.g.snipmate_snippets_path = "./lua/snippets/snipmate"
		end,
		cmd = { "LuaSnipListAvailable" },
		opts = function()
			local ls = require("luasnip")
			local map = vim.keymap.set
			local opts = function(desc)
				return { noremap = true, silent = true, desc = desc }
			end

			map({ "i" }, "<C-Tab>", ls.expand, opts("Expand snippet inline"))
			map({ "i", "s" }, "<C-l>", function()
				ls.jump(1)
			end, opts("Snippet jump forward"))
			map({ "i", "s" }, "<C-h>", function()
				ls.jump(-1)
			end, opts("Snippet jump backward"))

			map({ "i", "s" }, "<C-n>", function()
				if ls.choice_active() then
					ls.change_choice(1)
				end
			end, opts("Snippet next choice"))

			map({ "i", "s" }, "<C-p>", function()
				if ls.choice_active() then
					ls.change_choice(-1)
				end
			end, opts("Snippet previous choice"))

			require("luasnip.loaders.from_snipmate").lazy_load({ paths = vim.g.snipmate_snippets_path })
			require("luasnip.loaders.from_lua").lazy_load({ paths = vim.g.lua_snippets_path })

			map("n", "<leader>Cs", function()
				require("luasnip.loaders").edit_snippet_files({
					ft_filter = function(filetype)
						return filetype == vim.bo.filetype
					end,
					format = function(_, source_name)
						return source_name
					end,
          edit = function(path)
            vim.cmd.new()
            vim.cmd("edit " .. path)

            local editor_width = vim.api.nvim_get_option_value('columns', {scope = "global"})
            local editor_height = vim.api.nvim_get_option_value('lines', {scope = "global"})
            local width = math.floor(0.8 * editor_width)
            local height = math.floor(0.8 * editor_height)

            local float_opts = {
              relative = 'editor',
              width = width,
              height = height,
              col = math.floor((editor_width - width) / 2),
              row = math.floor((editor_height - height) / 2),
              border = { "╔", "═" ,"╗", "║", "╝", "═", "╚", "║" },
              title = "Edit snippets",
              title_pos = "center"
            }

            vim.api.nvim_win_set_config(0, float_opts)
          end
				})
			end, { desc = "Edit snippets" })

			return {
				enable_autosnippets = true,
        store_selection_leys = "<Tab>"
			}
		end,
	},
}
