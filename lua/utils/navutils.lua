local getwin = vim.api.nvim_get_current_win
local setwin = vim.api.nvim_set_current_win
local getwidth = vim.api.nvim_win_get_width
local setwidth = vim.api.nvim_win_set_width
local getheight = vim.api.nvim_win_get_height
local setheight = vim.api.nvim_win_set_height

local function increase_width(window, amount)
	--- Increase width of {window} by {amount} units. Can also decrease the width if {amount} is a negative number
	local win = getwin()
	setwidth(win, getwidth(win) + amount)
end

local function increase_height(window, amount)
	--- Increase height of {window} by {amount} units. Can also decrease the width if {amount} is a negative number
	local win = getwin()
	setheight(win, getheight(win) + amount)
end

local M = {}

local is_rightmost = function()
	local curwin = getwin()
	vim.cmd("wincmd l")
	local rightwin = getwin()
	if curwin == rightwin then
		return true
	else
		setwin(curwin)
		return false
	end
end

local is_leftmost = function()
	local curwin = getwin()
	vim.cmd("wincmd h")
	local leftwin = getwin()
	if curwin == leftwin then
		return true
	else
		setwin(curwin)
		return false
	end
end

local is_bottommost = function()
	local curwin = getwin()
	vim.cmd("wincmd j")
	local bottomwin = getwin()
	if curwin == bottomwin then
		return true
	else
		setwin(curwin)
		return false
	end
end

local is_topmost = function()
	local curwin = getwin()
	vim.cmd("wincmd k")
	local topwin = getwin()
	if curwin == topwin then
		return true
	else
		setwin(curwin)
		return false
	end
end

M.resize_left = function()
	if is_rightmost() then
		if not is_leftmost() then
			increase_width(getwin(), 1)
		end
	else
		increase_width(getwin(), -1)
	end
end

M.resize_right = function()
	if is_rightmost() then
		if not is_leftmost() then
			increase_width(getwin(), -1)
		end
	else
		increase_width(getwin(), 1)
	end
end

M.resize_up = function()
	if is_bottommost() then
		if not is_topmost() then
			increase_height(getwin(), 1)
		end
	else
		increase_height(getwin(), -1)
	end
end

M.resize_down = function()
	if is_bottommost() then
		if not is_topmost() then
			increase_height(getwin(), -1)
		end
	else
		increase_height(getwin(), 1)
	end
end

-- Tab utils
local function get_max_tab(keystroke)
	local tabpages = vim.api.nvim_list_tabpages()
	if keystroke > #tabpages then
		return tabpages[#tabpages]
	else
		return tabpages[keystroke]
	end
end

M.get_current_tab = function()
	return vim.api.nvim_tabpage_get_number(vim.api.nvim_get_current_tabpage())
end

M.go_to_tab = function(keystroke)
	vim.api.nvim_set_current_tabpage(get_max_tab(keystroke))
end

return M
