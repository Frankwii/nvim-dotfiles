local map = vim.keymap.set
-- For some reason, normal-mode <C-i> was not working properly.
map("n", "<C-i>", "<C-i>", { remap = false, desc = "Go back in the jumplist" })
map("n", "<C-o>", "<C-o>", { remap = false, desc = "Go forth in the jumplist" })

map("n", "<leader>cd", vim.diagnostic.setloclist, { desc = "LSP diagnostic loclist" })

-- Default options
local options = { noremap = true, silent = true }
local function opts(desc)
  return { noremap = true, silent = true, desc = desc }
end

-- Insert mode useful mappings
map("i", "<C-e>", "<esc>A", opts "Insert at the end")


-- Kill search highlights
map("n", "<esc>", ":noh<CR>", options)


-- Comfortable wrapped-line displacement with ctrl-alt:
map("", "<C-M-h>", "g0", options)
map("", "<C-M-j>", "gj", options)
map("", "<C-M-k>", "gk", options)
map("", "<C-M-l>", "g$", options)

-- For navigating help files
map("", "<C-S-j>", function()
	vim.cmd("tag " .. vim.fn.expand("<cword>"))
end, options)

-- Save, close, quit
map("n", "<C-w>", vim.cmd.write, { silent = true, noremap = true, nowait = true })
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

--- Config mappings
-- Reload config
map('n', '<leader>Cr', function()
  vim.cmd("restart")
end, opts "Reload neovim")

-- New plugin
map('n', '<leader>Cp', function ()
  local file_name = vim.fn.input("File name: ")

  local nvim_home = require("utils.nvim_home")

  local plugin_file = nvim_home .. "/lua/plugins/" .. file_name
  vim.cmd("e " .. plugin_file)
end, opts "New plugin")

--- In-file cool movements. Some inspired by ThePrimeagen's, some my own.
map("n", "<C-j>", "mQa<CR><esc>==`Q", opts "Add line in-place")
map("n", "Y", "yg$", opts "Yank the rest of the line")
map("n", "J", "mQJ`Q", opts "Remove newline wihtout moving the cursor")
map("n", "<C-d>", "<C-d>zz", opts "Centered scroll downwards")
map("n", "<C-u>", "<C-u>zz", opts "Centered scroll upwards")
map("n", "n", "nzz", opts "Centered search next")
-- Normal
map("n", "N", "Nzz", opts "Centered search previous")

-- Visual
--- @param count integer
-- local function move_selection_upwards(count)
--   local fks = require("utils.motions").blocking_feedkeys
--   local goto = function(pos) vim.api.nvim_win_set_cursor(0, pos) end
--   local curpos = function() vim.api.nvim_win_get_cursor(0) end
--   local pos1 = curpos()
--   fks({"o", "<esc>"})
--   local pos2 = curpos()
--
--   local row_diff = math.abs(pos1[1] - pos2[1])
--
--   new_pos1 = {pos1[1] + count, pos1[2]}
--   new_pos2 = {pos2[1] + count, pos2[2]}
--
--   fks(string.rep("j", count + 1) .. "$")
--   goto(pos1)
--   fks("V")
--   goto(pos2)
-- end

map('v', 'v', function() require("utils.motions").feedkeys_and_return_cursor({'o', '<esc>', 'V'})end, opts "Switch search to visual-line")
map('v', ',', "mQ:norm A,<CR>`Q", opts "Append commas to the end of all selected lines.")

