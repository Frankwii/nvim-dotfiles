return {
  {
    "kylechui/nvim-surround",
    event = "VeryLazy",
    opts = {
      keymaps = {
        insert = "<C-s>",
        insert_line = "<C-S>",
        normal = "s",
        normal_cur = "S",
        normal_line = "gs",
        normal_cur_line = "gS",
        visual = "s",
        visual_line = "S",
        delete = "ds",
        change = "cs",
        change_line = "cS",
      },
    },
    aliases = {
      ["a"] = ">",
      ["p"] = ")",
      ["b"] = ")",
      ["B"] = "}",
      ["r"] = "]",
      ["q"] = { '"', "'", "`" },
      ["s"] = { "}", "]", ")", ">", '"', "'", "`" },
    }
  }
}
