local utils = require "snippets.utils"

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

return {
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
  s({trig="nn", name="Norm"},
    {
      insertTextInBetween(1, "\\|", "\\|"), subindexIfNonempty(2), i(0)
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
    {insertTextInBetween(1, "\\mathbb{","}"), i(0)}
  ),
  -- s({trig="Test", name="Testing"}, {utils.surroundIfInsert(1, {"(", ")"}, i(2))}),
  -- utils.test(),
  -- s("extras6", { i(1, ""), t { "", "" }, extras.nonempty(1, "not empty!", "empty!") })
}
-- Autotrigger
,{
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

}
