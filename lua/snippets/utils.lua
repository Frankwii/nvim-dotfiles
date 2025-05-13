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
-- local postfix = require("luasnip.extras.postfix").postfix
-- local types = require("luasnip.util.types")
-- local parse = require("luasnip.util.parser").parse_snippet
-- local ms = ls.multi_snippet
-- local k = require("luasnip.nodes.key_indexer").new_key

local M = {}

local function insertTextInBetween(jump_index, left_text, right_text)
  return sn(jump_index, {t(left_text),i(1),t(right_text),i(0)})
end

M.surroundInsert = function(jump_index, pair)
  --- jump_index = 1
  --- pair = {"(", ")"}
  return sn(jump_index, {t(pair[1]), i(1), t(pair[2]), i(0)})
end

-- M.surroundIfInsert= function(jump_index, pair)
--   return sn(
--     jump_index,
--     {t(pair[1]), i(1), t(pair[2]), f(
--       function(argnode_text, parent)
--         return parent.env.
--       end, {1}, {})}
--   )
-- end
M.test = function()
return s("transform", {
		i(1, "initial text"),
		t({ "", "" }),
		-- lambda nodes accept an l._1,2,3,4,5, which in turn accept any string transformations.
		-- This list will be applied in order to the first node given in the second argument.
		l(l._1:match("[^i]*$"):gsub("i", "o"):gsub(" ", "_"):upper(), 1),
	})
end
return M
