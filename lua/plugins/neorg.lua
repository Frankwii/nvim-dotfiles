local map = vim.keymap.set
local function opts(desc)
	return {
		silent = true,
		remap = false,
		desc = desc,
		buffer = true,
	}
end

local function imports()
	return require("luasnip"), require("neorg.modules.external.templates.default_snippets")
end

---@param mode string | string[]
---@param lhs string
---@param func string
---@param map_opts table
local map_neorg = function(mode, lhs, func, map_opts)
	map(mode, lhs, "<Plug>(" .. func .. ")", map_opts)
end

--- Set mappings
local neorg_augroup = vim.api.nvim_create_augroup("NeorgAutocommands", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
	group = neorg_augroup,
	pattern = "norg",
	callback = function(_)
		vim.wo.conceallevel = 3
		local function increase_conceallevel()
			vim.wo.conceallevel = math.min(3, vim.wo.conceallevel + 1)
		end
		local function decrease_conceallevel()
			vim.wo.conceallevel = math.max(0, vim.wo.conceallevel - 1)
		end
		--- Movement/editing utilities
		-- Conceal level
		map("n", "<M-+>", increase_conceallevel, opts("Increase conceal"))
		map("n", "<M-->", decrease_conceallevel, opts("Decrease conceal"))
		-- Hopping around
		map_neorg("n", "<C-S-j>", "neorg.esupports.hop.hop-link", opts("Jump"))
		-- Next item
		map_neorg("i", "<C-CR>", "neorg.itero.next-iteration", opts("Next list element"))
    -- Increase/decrease indentation
    map_neorg("n", ">>", "neorg.promo.promote.nested", opts "Increase indentation")
    map_neorg("n", "<<", "neorg.promo.demote.nested", opts "Decrease indentation")
    map_neorg("i", "<C-t>", "neorg.promo.promote.nested", opts "Decrease indentation")
    map_neorg("i", "<C-d>", "neorg.promo.demote.nested", opts "Decrease indentation")

		--- Features
		require("which-key").add({
			{ "<leader>nJ", group = "󰺿 Journal" },
			{ "<leader>nf", group = " Find" },
		})
		-- New note
		map_neorg("n", "<leader>nn", "neorg.dirman.new-note", opts("Create new note"))
		-- Table of contents
		map("n", "<leader>nT", ":Neorg toc<cr>", opts("Table of contents"))
		-- Journal-related
		map("n", "<leader>nJJ", ":Neorg journal today<CR>", opts("Today"))
		-- map("n", "<leader>nJT", ":Neorg journal toc open<CR>", opts "Table of contents") -- currently not working
		map("n", "<leader>nJt", ":Neorg journal tomorrow<CR>", opts("Tomorrow"))
		map("n", "<leader>nJy", ":Neorg journal yesterday<CR>", opts("Yesterday"))
		map("n", "<leader>nJc", ":Neorg journal custom<CR>", opts("Choose"))
		-- Telescope babey
		map_neorg("n", "<leader>nff", "neorg.telescope.find_norg_files", opts("Files"))
		map_neorg("n", "<leader>nfl", "neorg.telescope.find_linkable", opts("Linkable"))
		map_neorg("n", "<leader>nfh", "neorg.telescope.search_headings", opts("Headings"))
		-- TODO: Figure out what this thing does
		map_neorg("n", "<leader>nfb", "neorg.telescope.backlincks.file_backlinks", opts("Backlinks"))
		map_neorg("n", "<leader>nfr", "neorg.telescope.backlincks.header_backlinks", opts("References"))
    map("n", "<leader>nr", ":Neorg return<CR>", opts "Return")
	end,
})
--- Tweaked journal templating
vim.api.nvim_create_autocmd({ "BufEnter" }, {
	group = neorg_augroup,
	desc = "Load journal template on non-empty journal entries",
	-- will work only this millenium (lol) and let some false positives through
	pattern = vim.fn.expand("~") .. "/neorg/journal/[0-2][0-9][0-9][0-9]-[0-1][0-9]-[0-3][0-9].norg",
	callback = function(args)
		vim.schedule(function()
			-- Loading lock; because of some implementation detail of
			-- the template plugin it would re-enter the buffer and
			-- cause this to trigger twice.
			if vim.b[args.buf].journal_template_loaded then
				return
			end
			local buffer_content = vim.api.nvim_buf_get_lines(args.buf, 0, -1, false)
			if not (#buffer_content > 1 or (#buffer_content == 1 and buffer_content[1] ~= "")) then
				vim.b[args.buf].journal_template_loaded = true
				vim.api.nvim_cmd({ cmd = "Neorg", args = { "templates", "fload", "journal" } }, {})
			end
		end)
	end,
})

--- Actual plugin
return {
	"nvim-neorg/neorg",
	dependencies = {
		{
      "benlubas/neorg-interim-ls",
      ft = { "norg" },
      version = "*",
    },
		{
      "pysan3/neorg-templates",
      dependencies = { "L3MON4D3/LuaSnip" },
      ft = { "norg" },
      version = "*",
    },
		{
      "nvim-neorg/neorg-telescope",
      ft = { "norg" },
      dependencies = { "nvim-lua/plenary.nvim" },
    },
		-- { "benlubas/neorg-query" , version = "1.4.0"},
	},
	lazy = true,
	cmd = { "Neorg" },
	ft = { "norg" },
	version = "9.3.0",
	opts = {
		load = {
			["core.defaults"] = {},
			["core.concealer"] = {
				config = {
					folds = false,
					icon_preset = "diamond",
				},
			},
			["core.dirman"] = {
				config = {
					workspaces = {
						root = "~/neorg",
						notes = "~/neorg/notes",
						archive = "~/neorg/archive", -- TODO: Take a look at plugin for this
						journal = "~/neorg/journal",
						templates = "~/neorg/templates",
					},
					default_workspace = "notes",
					use_popup = true,
				},
			},
			["core.keybinds"] = {
				config = {
					default_keybinds = false,
				},
			},
			["core.qol.toc"] = {
				close_after_use = true,
			},
			["core.completion"] = {
				config = { engine = { module_name = "external.lsp-completion" } },
			},
			["core.summary"] = {
				config = { strategy = "default" },
			},
			["core.journal"] = {
				config = {
					journal_folder = "journal",
					workspace = "root",
					strategy = "flat",
				},
			},
			["core.integrations.telescope"] = {},
			["external.interim-ls"] = {
				config = {
					completion_provider = {
						enable = true,
						documentation = true,
						-- Try to complete categories provided by Neorg Query. Requires `benlubas/neorg-query`
						categories = false,
					},
				},
			},
			["external.templates"] = {
				config = {
					template_dir = vim.fn.stdpath("config") .. "/templates/norg",
					default_subcommand = "load",
					keywords = {
						NOW = function()
							local ls, s = imports()
							local date = s.parse_date(0, os.time(), [[%Y-%m-%dT%H:%M:%S%z]])

							return ls.text_node(date)
						end,
						VERSION = function()
							local ls, _ = imports()

							return ls.text_node("1.1.1")
						end,
					},
				},
			},
      -- ["external.query"] = {
      --   config = {
      --     index_on_launch = true,
      --     update_on_change = true
      --   }
      -- }
		},
	},
}
