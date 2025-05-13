local map = vim.keymap.set

-- map({ "n", "x" }, "<leader>F", function()
--   require("conform").format { lsp_fallback = true }
-- end, { desc = "󰣟 Format file" })

map("n", "<leader>cd", vim.diagnostic.setloclist, { desc = "LSP diagnostic loclist" })

-- Terminals inside vim. This is really nice!

-- map("n", "<leader>T", function()
--   require("nvchad.term").new { pos = "sp" }
-- end, { desc = "terminal new horizontal term" })
--
--
-- map({ "n", "t" }, "<M-CR>", function()
--   require("nvchad.term").toggle { pos = "sp", id = "htoggleTerm" }
-- end, { desc = "terminal toggleable horizontal term" })
--
--
-- map({ "n", "t" }, "<M-f>", function()
--   require("nvchad.term").toggle { pos = "float", id = "floatTerm" }
-- end, { desc = "terminal toggle floating term" })

-- Telescope

-- Default options
local options = { noremap = true, silent = true }
-- Kill search highlights
map("n", "<esc>", "<cmd>noh<CR>", options)

-- Comfortable wrapped-line displacement with ctrl-alt:
map("", "<C-M-h>", "g0", options)
map("", "<C-M-j>", "gj", options)
map("", "<C-M-k>", "gk", options)
map("", "<C-M-l>", "g$", options)

-- Add a line in-place
map("n", "<C-j>", "a<CR><esc>==k$hl", options)

-- For navigating help files
map("", "<C-S-j>", function()
	vim.cmd("tag " .. vim.fn.expand("<cword>"))
end, options)

-- Save, close, quit
map("n", "<C-w>", vim.cmd.write, { silent = true, noremap = true, nowait = true })
-- map('n','<C-b>',require("nvchad.tabufline").close_buffer,options)
-- map('n','<M-b>',require("nvchad.tabufline").close_buffer,options)
map("n", "<C-q><C-q>", "<cmd>q!<cr>", options)

-- Navigate buffers
map("n", "<M-n>", vim.cmd.bnext, options)
map("n", "<M-p>", vim.cmd.bprevious, options)

-- Window-related
map({ "n", "v" }, "<M-h>", "<C-w>h", options)
map({ "n", "v" }, "<M-j>", "<C-w>j", options)
map({ "n", "v" }, "<M-k>", "<C-w>k", options)
map({ "n", "v" }, "<M-l>", "<C-w>l", options)

map({ "n", "v" }, "<M-H>", "<C-w>H", options)
map({ "n", "v" }, "<M-J>", "<C-w>J", options)
map({ "n", "v" }, "<M-K>", "<C-w>K", options)
map({ "n", "v" }, "<M-L>", "<C-w>L", options)

-- Intuitive resizing options!
local navutils = require("utils.navutils")
map({ "n", "v" }, "<M-Left>", navutils.resize_left, options)
map({ "n", "v" }, "<M-Down>", navutils.resize_down, options)
map({ "n", "v" }, "<M-Up>", navutils.resize_up, options)
map({ "n", "v" }, "<M-Right>", navutils.resize_right, options)
map({ "n", "v" }, "<M-C-0>", "<C-w>=", options)

map({ "n", "v" }, "<M-w>", "<C-w>n", options)
map({ "n", "v" }, "<M-q>", "<C-w>c", options)
map({ "n", "v" }, "<M-s><M-s>", "<C-w>v", options)
map({ "n", "v" }, "<M-s><M-v>", "<C-w>s", options)

-- Tab-related
map("n", "<Tab>", vim.cmd.tabnext, options)
map("n", "<S-Tab>", vim.cmd.tabprevious, options)
map("n", "<M-0>", vim.cmd.tablast, options)
map("n", "<M-a>", vim.cmd.tabnew, options)
map("n", "<M-c>", vim.cmd.tabclose, options)

-- Tab utils
for i = 1, 9 do
	map("n", "<M-" .. tostring(i) .. ">", function()
		navutils.go_to_tab(i)
	end, options)
	map("n", "<M-" .. tostring(i) .. ">", function()
		navutils.go_to_tab(i)
	end, options)
end
