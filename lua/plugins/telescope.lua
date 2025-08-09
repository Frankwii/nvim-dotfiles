return {
  'nvim-telescope/telescope.nvim',
  init = function()
    require "mappings.telescope"
  end,
  dependencies = {
    'nvim-lua/plenary.nvim',
    -- {
    --   "nvim-telescope/telescope-fzf-native.nvim",
    --   build = "make",
    -- }
  },
  cmd = {"Telescope"},
  lazy = true,
  opts = function()
    local actions = require "telescope.actions"
    return {
      defaults={
        mappings={
          n = {
            ["q"] = actions.close,
            --- Results movement
            ["<C-k>"] = actions.results_scrolling_up,
            ["<C-j>"] = actions.results_scrolling_down,

            --- Opening files
            ["<M-s>"] = actions.file_vsplit,
            ["<M-v>"] = actions.file_split,
            ["T"] = actions.file_tab,

            -- Marks
            ["m"] = function()
              local bufn = vim.api.nvim_get_current_buf()
              actions.toggle_selection(bufn)
              actions.move_selection_previous(bufn)
            end,

            ["M"] = function()
              local bufn = vim.api.nvim_get_current_buf()
              actions.toggle_selection(bufn)
              actions.move_selection_next(bufn)
            end,

            -- Preview
            ["<C-M-j>"] = actions.preview_scrolling_down,
            ["<C-M-k>"] = actions.preview_scrolling_up,
          },
          i = {
            ["<C-j>"] = actions.move_selection_next,
            ["<C-k>"] = actions.move_selection_previous,

            --- Opening files
            ["<M-s>"] = actions.file_vsplit,
            ["<M-v>"] = actions.file_split,

            -- Preview
            ["<C-M-j>"] = actions.preview_scrolling_down,
            ["<C-M-k>"] = actions.preview_scrolling_up,
          },
        },
        -- Picker control
        scroll_strategy="limit",
        initial_mode="insert",
        path_display={truncate=2},
        -- Layout
        layout_strategy = "bottom_pane",
        layout_config = {
          bottom_pane = {
            height = 15,
            preview_cutoff = 100,
          },
        },
        -- Aesthetics
        border=false,
        prompt_prefix="󰈞 ",
        entry_prefix="- ",
      },
      load_extension = {
        "fzf",
        "lazygit"
      }
    }
  end
}
