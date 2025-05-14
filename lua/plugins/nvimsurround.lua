return {
  {
    "kylechui/nvim-surround",
    event = "VeryLazy",
    init = function()
      local map = vim.keymap.set
      map("o", "ir", "i[")
      map("o", "ar", "a[")
      map("o", "ia", "i<")
      map("o", "aa", "a<")
    end,
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
