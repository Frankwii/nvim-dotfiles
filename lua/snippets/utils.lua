local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
-- local isn = ls.indent_snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local r = ls.restore_node
local events = require("luasnip.util.events")
-- local ai = require("luasnip.nodes.absolute_indexer")
local extras = require("luasnip.extras")
local l = extras.lambda
-- local rep = extras.rep
-- local p = extras.partial
-- local m = extras.match
-- local n = extras.nonempty
-- local dl = extras.dynamic_lambda
-- local fmt = require("luasnip.extras.fmt").fmt
-- local fmta = require("luasnip.extras.fmt").fmta
-- local conds = require("luasnip.extras.expand_conditions")
local postfix = require("luasnip.extras.postfix").postfix
-- local types = require("luasnip.util.types")
-- local parse = require("luasnip.util.parser").parse_snippet
-- local ms = ls.multi_snippet
-- local k = require("luasnip.nodes.key_indexer").new_key

local M = {}

local escape_lua_pattern_literal = function(str)
	local pattern_to_match = "([%(%)%.%%%+%-%*%?%[%^%$])"

	local subbed = string.gsub(str, pattern_to_match, "%%%1")
	return subbed
end

local function insertTextInBetween(jump_index, left_text, right_text)
	return sn(jump_index, { t(left_text), i(1), t(right_text), i(0) })
end

M.surround_insert = function(jump_index, pair)
	--- jump_index = 1
	--- pair = {"(", ")"}
	return sn(jump_index, { t(pair[1]), i(1), t(pair[2]), i(0) })
end

M.surround_if_inserted = function(jump_index, pair)
	return postfix({
		trig = "",
		match_pattern = escape_lua_pattern_literal(pair[1]) .. escape_lua_pattern_literal(pair[2]) .. "$",
	}, { l("") })
end

return M
