return {
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",
  dependencies = {
    'nvim-tree/nvim-web-devicons'
  },
  opts = {
    options = {
      theme = 'auto', -- lualine theme
      component_separators = { left = '', right = '' },
      section_separators = { left = '', right = '' },
      disabled_filetypes = {     -- Filetypes to disable lualine for.
          statusline = {},       -- only ignores the ft for statusline.
          winbar = {},           -- only ignores the ft for winbar.
      },
      ignore_focus = {},         -- If current filetype is in this list it'll
                                 -- always be drawn as inactive statusline
                                 -- and the last window will be drawn as active statusline.
                                 -- for example if you don't want statusline of
                                 -- your file tree / sidebar window to have active
                                 -- statusline you can add their filetypes here.
                                 --
                                 -- Can also be set to a function that takes the
                                 -- currently focused window as its only argument
                                 -- and returns a boolean representing whether the
                                 -- window's statusline should be drawn as inactive.
      always_divide_middle = true, -- When set to true, left sections i.e. 'a','b' and 'c'
                                   -- can't take over the entire statusline even
                                   -- if neither of 'x', 'y' or 'z' are present.
      always_show_tabline = true, -- When set to true, if you have configured lualine for displaying tabline
                              -- then tabline will always show. If set to false, then tabline will be displayed
                              -- only when there are more than 1 tab. (see :h showtabline)
      globalstatus = true,        -- enable global statusline (have a single statusline
                                   -- at bottom of neovim instead of one for  every window).
                                   -- This feature is only available in neovim 0.7 and higher.
      refresh = {                  -- sets how often lualine should refresh it's contents (in ms)
        statusline = 100,         -- The refresh option sets minimum time that lualine tries
        tabline = 100,            -- to maintain between refresh. It's not guarantied if situation
        winbar = 100              -- arises that lualine needs to refresh itself before this time
                                   -- it'll do it.
                                   -- Also you can force lualine's refresh by calling refresh function
                                   -- like require('lualine').refresh()
      }
    },
    sections = {
      lualine_a = {
        { 'mode', icon = " " }
      },
      lualine_b = {
        { 'branch', icon = "󰘬 "},
        { 'diff' , icon = " ", color = {fg = "#fffeaf"}},
        { 'diagnostics' , icon = " ", sources = {'nvim_lsp'}, color = {fg = "#caffc3"}}
      },
      lualine_c = { { 'tabs', icon = "󰓩 " }, { 'windows', icon = " " } },
      lualine_z = {
        { 'location', icon = " "}
      },
      lualine_y = {
        { 'lsp_status', icon = " " }, 'searchcount', 'selectioncount'
      },
      lualine_x = {
        {'macro', fmt = function()
          local reg = vim.fn.reg_recording()
          if reg ~= "" then
            return "Recording @" .. reg
          end
          return nil
        end, draw_empty = false},
        'encoding',
        'fileformat',
        'filetype'
      }
    },
    extensions = {'nvim-tree'}
    },
  }
