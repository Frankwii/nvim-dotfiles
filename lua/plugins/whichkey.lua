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
        {"<leader>S", group=" Swap"},
        {"<leader>W", group=" Workspace"},
        {"<leader>w", group=" Windows"},
        {"<leader>r", group=" Run"},
        {"<leader>C", group="󱢚 Config"},
      })

      -- -- Hydra mappings for window resizing:
      -- local resize_keymap = vim.g.nonconflicting_hydra_keymap .. "R"
      --
      -- wk.add(
      --   {"<leader>wr", function ()
      --     wk.show({keys=resize_keymap, loop=true})
      --   end, desc="󰩨 Resize"}
      -- )
      --
      -- local navutils = require "utils.navutils"
      -- local windowmappings = {
      --   [" Left"] = {key="h", rhs = navutils.ResizeLeft},
      --   [" Down"] = {key="j", rhs = navutils.ResizeDown},
      --   [" Up"] = {key="k", rhs = navutils.ResizeUp},
      --   [" Right"] = {key="l", rhs = navutils.ResizeRight}
      -- }
      --
      -- local formatted_windowmappings = {}
      -- local i = 0
      -- for desc, spec in pairs(windowmappings) do
      --   table.insert(formatted_windowmappings, i, {
      --     resize_keymap .. spec.key,
      --     spec.rhs,
      --     desc = desc,
      --     mode = "n",
      --   })
      --   i = i+1
      -- end
      --
      -- wk.add(formatted_windowmappings)
      --- Add descriptions to groups
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
