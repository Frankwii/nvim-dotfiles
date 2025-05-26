local M = {}

--- @alias Position {integer, integer}

local function log(msg)
  local file = io.open("/home/frank/plugoutput.txt", 'a')
  local tw = msg
  if type(msg) == "table" then
    tw = table.concat(msg, ";")
  end
  file:write(tw .. "\n")
  file:close()
end

--- @param keys string | string[]
M.blocking_feedkeys = function(keys)
  if type(keys) == "string" then
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(keys, true, true, true), 'x', false)
  else
    for _, key in ipairs(keys) do
      M.blocking_feedkeys(key)
    end
  end
end

--- @param pos1 Position
--- @param pos2 Position
--- @return number
local function compute_distance(pos1, pos2)
	local d = vim.api.nvim_win_get_width(0) * (math.abs(pos1[1] - pos2[1])) + math.abs(pos1[2] - pos2[2])
  -- log({"DISTANCE: ",d})
  return d
end

--- @param motion string
--- @param initial_position Position
local function attempt_motion(motion, initial_position)
	M.blocking_feedkeys("v" .. motion)

	local right_position = vim.api.nvim_win_get_cursor(0)

  -- log(right_position)
  M.blocking_feedkeys("o")

	local left_position = vim.api.nvim_win_get_cursor(0)
  -- log(left_position)
  M.blocking_feedkeys('<esc>')

  vim.api.nvim_win_set_cursor(0, initial_position)

	return { left_position, right_position }
end

--- @param d1 number
--- @param d2 number
--- @return number
local function process_distances(d1, d2)
  if math.max(d1, d2) == 0 then
    return math.huge
  else
    return math.min(d1, d2)
  end
end

--- @param aliased table<string>
local perfom_closest_motion = function(aliased)
	local initial_position = vim.api.nvim_win_get_cursor(0)
	local distances = {}
	for idx, motion in ipairs(aliased) do
		local positions = attempt_motion(motion, initial_position)
		distances[idx] =
			process_distances(compute_distance(initial_position, positions[1]), compute_distance(initial_position, positions[2]))
	end

  -- log(distances)

  local final_motion = "FINAL"
	local max_distance = math.huge
	for idx, _ in pairs(distances) do
    local distance = distances[idx]
    local motion = aliased[idx]
		if distance < max_distance then
			max_distance = distance
			final_motion = motion
		end
	end

	M.blocking_feedkeys("v" .. final_motion)
  -- log({"FINAL MOTION", final_motion})
end

--- @param aliased table<string>
--- @param alias string
--- @param opts? vim.keymap.set.Opts
M.map_alias_motion = function(alias, aliased, opts)
  local opts_ = opts or { noremap = true, silent = false, desc = "Operator alias: " .. alias}
	vim.keymap.set({ "o", "v" }, alias, function()
		  M.blocking_feedkeys("<esc>")
		perfom_closest_motion(aliased)
	end, opts_)
end


--- @param keys string | string[]
M.feedkeys_and_return_cursor = function(keys)
  local curpos = vim.api.nvim_win_get_cursor(0)
  M.blocking_feedkeys(keys)
  vim.api.nvim_win_set_cursor(0, curpos)
end


return M
