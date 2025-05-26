local utils = require "snippets.utils"
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta

local ls = require "luasnip"
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node

local extras = require "luasnip.extras"
local l = extras.lambda
local rep = extras.rep


local function capitalize(str)
    -- Handle empty or nil strings
    if not str or #str == 0 then
        return ""
    end
    -- Capitalize the first character and concatenate with the rest of the string
    return string.upper(string.sub(str, 1, 1)) .. string.sub(str, 2)
end

local greek_letters = {
  a = "alpha",
  b = "beta",
  c = "chi",
  d = "delta",
  g = "gamma",
  i = "iota",
  k = "kappa",
  l = "lambda",
  m = "mu",
  n = "nu",
  o = "omega",
  p = "pi",
  r = "rho",
  s = "sigma",
  t = "tau",
  u = "upsilon",
  x = "xi",
  y = "psi",
  z = "zeta"
}

local mappings = {}

for k, v in pairs(greek_letters) do
  mappings[";" .. k] = v
  mappings[";" .. k:upper()] = capitalize(v)
end

local var_greek_letters = {
  e = "epsilon",
  f = "phi",
}

for k, v in pairs(var_greek_letters) do
  mappings[";" .. k] = "var" .. v
  mappings[";" .. k:upper()] = "var" .. capitalize(v)
end

local function inMath()
  return vim.fn['vimtex#syntax#in_mathzone()']()==1
end

local function insertTextInBetween(jump_index, left_text, right_text)
  return sn(jump_index, {t(left_text),i(1),t(right_text),i(0)})
end

local function isWritten(args,parent,user_args)
  return args[1][1]~="" and user_args or ""
end

local function surroundIfNonempty(jump_index, symbol, insert_symbol)
  insert_symbol = insert_symbol or ""
  return sn(jump_index,{
    f(isWritten,{1},{user_args={symbol.."{"}}),i(1,insert_symbol),
    f(isWritten,{1},{user_args={"}"}}),
  })
end

local function subindexIfNonempty(jump_index, insert_symbol)
  return surroundIfNonempty(jump_index, "_", insert_symbol)
end

local function superindexIfNonempty(jump_index, insert_symbol)
  return surroundIfNonempty(jump_index, "^", insert_symbol)
end

local function call_function(latex_function, nparams, jump_index)
  if jump_index == nil then
    jump_index = 1
  end

  local fmta_string = [[\]] .. latex_function .. string.rep([[{<>}]], nparams) .. [[<>]]

  local insert_nodes = {}

  for idx=1,nparams do
    table.insert(insert_nodes, i(idx))
  end

  table.insert(insert_nodes, i(0))

  return sn(jump_index, fmta(fmta_string, insert_nodes))
end

local snippets = {
  s({trig="II",name="Integral"},
    {
      t("\\int"),
      f(isWritten,{1},{user_args={"_{"}}),i(1,"a"),
      f(isWritten,{1},{user_args={"}"}}),
      f(isWritten,{2},{user_args={"^{"}}),i(2,"b"),f(isWritten,{2},{user_args={"}"}}),i(3,"f"),
      t("~d"),i(4,"\\mu"),i(0)
    }
  ),
  s({trig="SS", name="Sum"},
    {
      t("\\sum"),
      f(isWritten,{1},{user_args={"_{"}}),i(1,"i=1"),
      f(isWritten,{1},{user_args={"}"}}),
      f(isWritten,{2},{user_args={"^{"}}),i(2,"n"),f(isWritten,{2},{user_args={"}"}}),i(3,""),i(0)
    }
  ),
  s({trig="ama", name="Argmax"},
  {t("\\text{argmax}"), subindexIfNonempty(1), insertTextInBetween(2, "\\left(", "\\right)")}
  ),
  s({trig="ami", name="Argmin"},
  {t("\\text{argmin}"), subindexIfNonempty(1), insertTextInBetween(2, "\\left(", "\\right)")}
  ),
  s({trig="cal", name="Mathcal"},
    {insertTextInBetween(1, "\\mathcal{","}"), i(0)}
  ),
  s({trig="bb", name="Mathbb"},
    {insertTextInBetween(1, "\\mathbb{","}"), i(0)}),
  s({trig="sec", name="Section"},
    {insertTextInBetween(1, "\\section{", "}"), i(0)}),
  s({trig="ssec", name="Subsection"},
    {insertTextInBetween(1, "\\subsection{", "}"), i(0)}),
  s({trig="sssec", name="Subsubsection"},
    {insertTextInBetween(1, "\\subsubsection{", "}"), i(0)}),

  s({trig="lab", name="Label"}, call_function("label", 1)),
  s({trig="cref", name="Cref"}, call_function("cref", 1)),


  s({trig="beg", name="Environment"},
    fmta(
      [[
        \begin{<>}
          <>
        \end{<>}
      ]],
      {i(1), i(0), rep(1)}
    )
  )
}

local autosnippets = {
  s({trig="mk"}, {
    t("\\("), i(1),t("\\)"),i(0)
  }),
  s({trig="dm"}, {
    t({"\\["}),
      t({"","\t"}),i(0),
    t({"",".\\]"})
  }),
  s({trig="bf"}, {
    t({"\\textbf{"}), i(1), t({"}"}), i(0)
  }),
  s({trig="tt"}, {
    t({"\\textit{"}), i(1), t({"}"}), i(0)
  }),
  s({trig="mm"}, {
    t({"\\emph{"}), i(1), t({"}"}), i(0)
  }),
  s({trig="vb"}, {
    t({"\\verb|"}), i(1), t({"|"}), i(0)
  }),
  s({trig="nn", name="Norm"},
    {
      insertTextInBetween(1, "\\|", "\\|"), subindexIfNonempty(2), i(0)
    }
  ),
}

for k, v in pairs(mappings) do
  local trig = k
  local name = "Greek letter: " .. v
  local latex_command = "\\" .. v

  -- Create a snippet for the Greek letter
  table.insert(autosnippets, s({trig=trig, name=name}, {t(latex_command)}))
end

return snippets, autosnippets
