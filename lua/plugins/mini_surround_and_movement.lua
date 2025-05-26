return {
	{
		"echasnovski/mini.surround",
    keys = {{'s', mode={'n', 'v', 'o'}}, {'cs', mode={'n','o'}}, {'ds', mode={'n'}}},
		opts = {
			mappings = {
				add = "s", -- Add surrounding in Normal and Visual modes
				delete = "ds", -- Delete surrounding
				replace = "cs", -- Replace surrounding

				find = "sf", -- Find surrounding (to the right)
				find_left = "sF", -- Find surrounding (to the left)
				highlight = "", -- Highlight surrounding
				update_n_lines = "", -- Update `n_lines`
				suffix_last = "", -- Suffix to search with "prev" method
				suffix_next = "", -- Suffix to search with "next" method
			},
			search_method = "cover_or_next",
			custom_surroundings = {
				["s"] = {
					input = { { "%b()", "%b{}", "%b[]", '%b""', "%b''", "%b``" }, "^.().*().$" },
				},
				["B"] = {
          input = { "%b{}", "^.().*().$"},
          output = { left = "{", right = "}" },
        },
				["r"] = {
          input = { "%b[]", "^.().*().$"},
          output = { left = "[", right = "]" },
        },
			},
		},
	},
  {
		"echasnovski/mini.ai",
    keys = {
      {"a", mode={"o", "x"}},
      {"i", mode={"o", "x"}},
      "m",
      "M",
      -- "ñ",
      -- "Ñ"
    },
    opts = function()
      local genspec = require("mini.ai").gen_spec
      local ts = genspec.treesitter
      return {
      custom_textobjects = {
        s = {{ "%[().*()%]", "%(().*()%)", "%{().*()%}", "\"().*()\"", "'().*()'", "`().*()`" }},
        r = genspec.pair("[", "]", {type="balanced"}),
        a = genspec.pair("<", ">", {type="balanced"}),
        c = genspec.function_call(),
        -- f = "",
        l = ts({ a = '@loop.outer', i = '@loop.inner' }),
        f = ts({ a = '@function.outer', i = '@function.inner' }),
        C = ts({ a = '@conditional.outer', i = '@conditional.inner' }),
        p = ts({ a = '@parameter.outer', i = '@parameter.inner' }),
        k = ts({ a = '@class.outer', i = '@class.inner' }),
        t = ts({ a = '@type.outer', i = '@type.inner' }),
      },

      mappings = {
        goto_left = "m",
        goto_right = "M"
      }
    }
  end
  }
}
