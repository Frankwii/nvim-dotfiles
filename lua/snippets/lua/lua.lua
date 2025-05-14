return {

  s("fun", {
    t("function "), i(1, "name"), t("("), i(2, "args"), t({")",""}),
    t("\t"), i(3, "-- body"), t({"",""}),
    t({"end",""}),
    i(0)
  }),

  s("loc", {t("local ")}),

},
{
  s("LL",{t("<leader>"),i(0)}),
}
