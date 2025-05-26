return {
	"nvim-tree/nvim-tree.lua",
	init = function()
		vim.keymap.set("n", "<M-t>", function()
			vim.cmd("NvimTreeToggle")
		end, { desc = "Toggle nvim-tree" })
	end,
	opts = {
		on_attach = function(bufnr)
			local api = require("nvim-tree.api")
			local map = vim.keymap.set
			local function opts(desc)
				return { desc = "Tree: " .. desc, buffer = bufnr, noremap = true, silent = true }
			end
			local function under_cursor(func)
				func(api.tree.get_node_under_cursor())
			end

      map("n", "-", function ()
        api.tree.close()
        api.tree.open({find_file=true, update_root=true})
      end , opts "Open tree in current buffer")
			map("n", "q", api.tree.close, opts("Close tree"))
			map("n", "h", api.node.navigate.parent_close, opts("Close directory"))
			map("n", "H", api.tree.change_root_to_parent, opts("Change root to parent"))
			map("n", "l", function()
        api.node.open.edit()
			end, opts("Open node"))
      map("n", "T", function ()
        local navutils = require("utils.navutils")
        local curtab = navutils.get_current_tab()
        api.node.open.tab(nil, { focus = true })
        navutils.go_to_tab(curtab)
      end, opts "Open in another tab, keep focus on current")
      map("n", "t", function ()
        api.node.open.tab(nil, {quit_on_open=true})
        api.tree.open({find_file=true})
      end, opts "Open in new tab and switch to it")
			map("n", "L", function()
				local current_node = api.tree.get_node_under_cursor()

				if current_node.type == "directory" then
					api.tree.change_root_to_node()
					api.node.navigate.sibling.first()
				else
					api.node.open.edit()
				end
			end, opts("Change directory or edit file."))
			map("n", "J", api.node.navigate.sibling.last, opts("Last Sibling"))
			map("n", "K", api.node.navigate.sibling.first, opts("First Sibling"))
			map("n", "?", api.tree.toggle_help, opts("Help"))
			map("n", ".", api.tree.toggle_hidden_filter, opts("Toggle dotfiles"))
			map("n", "n", api.fs.create, opts("Create file"))
			map("n", "r", api.fs.rename_node, opts("Rename file or folder"))
			map("n", "s", function()
				api.node.open.vertical()
				api.tree.open()
			end, opts("Split vertical"))
			map("n", "v", function()
				api.node.open.horizontal()
				api.tree.open()
			end, opts("Split horizontal"))
			-- Marks-related
			map("n", "m", function()
				under_cursor(api.marks.toggle)
				vim.api.nvim_feedkeys("j", "n", false) -- press j; this emulates nnn behavior
			end, opts("Toggle mark"))
			map("n", "c", api.marks.clear, opts("Clear marks"))

			local function bulk_delete()
				if next(api.marks.list()) == nil then
					under_cursor(api.fs.remove)
				else
					api.marks.bulk.delete()
				end
			end
			map("n", "x", bulk_delete, opts("Delete marked files"))

			local function bulk_paste()
				local marked_nodes = api.marks.list()
				if next(marked_nodes) == nil then
					vim.api.nvim_echo({ { "No nodes marked", "None" } }, false, {})
				else
					for _, node in ipairs(marked_nodes) do
						api.fs.copy.node(node)
						under_cursor(api.fs.paste)
					end
					api.fs.clear_clipboard()
				end
			end
			map("n", "p", bulk_paste, opts("Paste marked files"))

			local function bulk_move()
				local marked_nodes = api.marks.list()
				if next(marked_nodes) == nil then
					vim.api.nvim_echo({ { "No nodes marked", "None" } }, false, {})
				else
					for _, node in ipairs(marked_nodes) do
						api.fs.cut(node)
						under_cursor(api.fs.paste)
					end
					api.fs.clear_clipboard()
				end
			end
			map("n", "v", bulk_move, opts("Move marked files"))
		end,
		hijack_cursor = true, -- no cursor right/left movement
		disable_netrw = true, -- conflicts with default nvim option
		modified = {
			enable = true, -- show modified files with a ·
		},
		filters = {
			dotfiles = false, -- don't hide dotfiles at start
		},
		view = {
			signcolumn = "yes", -- column with icons and bars
			side = "left",
		},
		renderer = {
			root_folder_label = ":~:s?$?/..?",
			highlight_opened_files = "name",
			highlight_modified = "name",
			highlight_bookmarks = "name",
			indent_markers = {
				enable = true, -- nice indent bars for folders and files
			},
			icons = {
				show = {
					folder_arrow = false, -- do not show an arrow > on folders
					-- it is ugly with the bars on
				},
				glyphs = {
					default = "󰈚",
					folder = {
						default = "",
						empty = "",
						empty_open = "",
						open = "",
						symlink = "",
					},
					git = { unmerged = "" },
				},
			},
			highlight_git = "icon",
		},
		actions = {
			open_file = {
				quit_on_open = false, -- close tree when opening a file
			},
		},
	},
}
