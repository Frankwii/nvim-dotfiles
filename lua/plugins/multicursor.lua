local function opts(desc)
	return { noremap = true, silent = true, desc = desc }
end

return {
	"jake-stewart/multicursor.nvim",
	branch = "1.0",
	keys = {
		"<up>",
		"<down>",
		"gm",
		{
			"I",
			function()
				require("multicursor-nvim").insertVisual()
			end,
			mode = { "v" },
			desc = "Insert visual block",
		},
		{
			"A",
			function()
				require("multicursor-nvim").insertVisual()
			end,
			mode = { "v" },
			desc = "Append visual block",
		},
	},
	config = function()
		local mc = require("multicursor-nvim")
		mc.setup()

		local set = vim.keymap.set

		-- Add or skip cursor above/below the main cursor.
		set({ "n", "x" }, "<up>", function()
			mc.lineAddCursor(-1)
		end, opts("New cursor above"))
		set({ "n", "x" }, "<down>", function()
			mc.lineAddCursor(1)
		end, opts("New cursor below"))
		set({ "n", "x" }, "<C-up>", function()
			mc.lineSkipCursor(-1)
		end, opts("Move only main cursor above"))
		set({ "n", "x" }, "<C-down>", function()
			mc.lineSkipCursor(1)
		end, opts("Move only main cursor below"))
		set({ "n", "x" }, "<C-left>", function()
			mc.skipCursor("h")
		end, opts("Move only main cursor left"))
		set({ "n", "x" }, "<C-right>", function()
			mc.skipCursor("l")
		end, opts("Move only main cursor right"))

		-- Add or skip adding a new cursor by matching word/selection
		set({ "n", "x" }, "gmn", function()
			mc.matchAddCursor(1)
		end, opts("Add a cursor at next match"))
		set({ "n", "x" }, "gms", function()
			mc.matchSkipCursor(1)
		end, opts("Skip next match for main cursor"))
		set({ "n", "x" }, "gmN", function()
			mc.matchAddCursor(-1)
		end, opts("Add a cursor at previous match"))
		set({ "n", "x" }, "gmS", function()
			mc.matchSkipCursor(-1)
		end, opts("Skip previous match for main cursor"))
		set({ "n", "x" }, "gma",  mc.matchAllAddCursors, opts("Add a cursor at every match"))
		set({ "n", "x" }, "gm=", mc.alignCursors, opts("Align cursors"))

		-- Disable and enable cursors.
		set({ "n", "x" }, "gmt", mc.toggleCursor, opts "Toggle cursor")
		set({ "n", "x" }, "gmm", mc.operator, opts "Motion")

		-- Mappings defined in a keymap layer only apply when there are
		-- multiple cursors. This lets you have overlapping mappings.
		mc.addKeymapLayer(function(layerSet)
			-- Select a different cursor as the main one.
			layerSet({ "n", "x" }, "<left>", mc.prevCursor)
			layerSet({ "n", "x" }, "<right>", mc.nextCursor)

			-- Delete the main cursor.
			layerSet({ "n", "x" }, "gmx", mc.deleteCursor)

			-- Enable and clear cursors using escape.
			layerSet("n", "<esc>", function()
				if not mc.cursorsEnabled() then
					mc.enableCursors()
				else
					mc.clearCursors()
				end
			end)
		end)

		-- Customize how cursors look.
		local hl = vim.api.nvim_set_hl
		hl(0, "MultiCursorCursor", { reverse = true })
		hl(0, "MultiCursorVisual", { link = "Visual" })
		hl(0, "MultiCursorSign", { link = "SignColumn" })
		hl(0, "MultiCursorMatchPreview", { link = "Search" })
		hl(0, "MultiCursorDisabledCursor", { reverse = true })
		hl(0, "MultiCursorDisabledVisual", { link = "Visual" })
		hl(0, "MultiCursorDisabledSign", { link = "SignColumn" })
	end,
}
