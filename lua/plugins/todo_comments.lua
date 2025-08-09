return {
  "folke/todo-comments.nvim",
  lazy = false,
  dependencies = { "nvim-lua/plenary.nvim" },
  cmds = {"TodoTelescope"},
  keys = {
    {"<leader>fT", ":TodoTelescope<CR>", desc="Find TODOs"}
  },
  opts = {}
}
