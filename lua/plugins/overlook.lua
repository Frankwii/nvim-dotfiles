return {
  "WilliamHsieh/overlook.nvim",
  keys = {
    { "<M-p>", mode = {"i", "n"}, function() require("overlook.api").peek_cursor() end, desc = "Overlook: Peek definition" },
    { "<M-S-q>", mode = {"i", "n"}, function() require("overlook.api").close_all() end, desc = "Overlook: Close all popups" },
    { "<M-u>", mode = {"i", "n"}, function() require("overlook.api").restore_popup() end, desc = "Overlook: Restore popup" },
    { "<M-S-u>", mode = {"i", "n"}, function() require("overlook.api").restore_popup() end, desc = "Overlook: Restore all popups" },
  },
  opts = {
    ui = {
      border = "double",
      keys = {},
      size_ratio = 0.8
    }
  },
}
