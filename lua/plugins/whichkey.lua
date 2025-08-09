return {
  {
    "folke/which-key.nvim",
    lazy = false,
    preset = "classic",
    keys = {"<leader>", '"', "'", "`", "g"},
    cmd = "WhichKey",

    opts = function()
      local wk = require "which-key"
      wk.add({
        {"<leader>c", group=" LSP"},
        {"<leader>f", group=" Find"},
        {"<leader>F", group=" Filetree"},
        {"<leader>cW", group=" Workspace"},
        {"<leader>w", group=" Windows"},
        {"<leader>r", group=" Run"},
        {"<leader>C", group="󱢚 Config"},
        {"<leader>n", group = "󰉐 Neorg" },
        {"<leader>A", group = "󱚟 AI" },
        {"gm", group = "󰇀 Multicursor" },
      })

      return {
        icons = {
          breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
          separator = "➜", -- symbol used between a key and it's label
          group = "", -- symbol prepended to a group
          ellipsis = "…",
          rules = false,
          -- use the highlights from mini.icons
          -- When `false`, it will use `WhichKeyIcon` instead
          colors = true,
          -- used by key format
          keys = {
            Up = " ",
            Down = " ",
            Left = " ",
            Right = " ",
            C = "C- ",
            M = "M- ",
            D = "󰘳 ",
            S = "S- ",
            CR = "󰌑 ",
            Esc = "󱊷 ",
            ScrollWheelDown = "󱕐 ",
            ScrollWheelUp = "󱕑 ",
            NL = "󰌑 ",
            BS = "󰁮",
            Space = "󱁐 ",
            Tab = "󰌒 ",
            F1 = "󱊫",
            F2 = "󱊬",
            F3 = "󱊭",
            F4 = "󱊮",
            F5 = "󱊯",
            F6 = "󱊰",
            F7 = "󱊱",
            F8 = "󱊲",
            F9 = "󱊳",
            F10 = "󱊴",
            F11 = "󱊵",
            F12 = "󱊶",
          },
        },
      plugins = {
        marks = true, -- shows a list of your marks on ' and `
        registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
        -- the presets plugin, adds help for a bunch of default keybindings in Neovim
        -- No actual key bindings are created
        spelling = {
          enabled = true, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
          suggestions = 20, -- how many suggestions should be shown in the list?
        },
        presets = {
          operators = true, -- adds help for operators like d, y, ...
          motions = true, -- adds help for motions
          text_objects = true, -- help for text objects triggered after entering an operator
          windows = false, -- default bindings on <c-w>
          nav = false, -- misc bindings to work with windows
          z = true, -- bindings for folds, spelling and others prefixed with z
          g = true, -- bindings for prefixed with g
        },
      },
      show_help = true, -- show a help message in the command line for using WhichKey
      show_keys = true, -- show the currently pressed key and its label as a message in the command line
      }
    end
  }
}
