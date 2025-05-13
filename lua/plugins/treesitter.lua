local mappings = require "mappings.treesitter"
return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  -- cmd = { "TSInstall", "TSBufEnable", "TSBufDisable", "TSModuleInfo" },
  dependencies = {
    {
      "nvim-treesitter/nvim-treesitter-textobjects",
      enabled = true
    },
  },
  opts = {
    ensure_installed={"lua", "python", "bash", "c", "cpp", "sql", "rust", "ron", "vim", "vimdoc", "html", "css"},
    -- Install parsers synchronously (only applied to `ensure_installed`)
    -- Set to "true" to force nvim to stop until the parser is installed.
    sync_install = false,

    -- Automatically install missing parsers when entering buffer
    -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
    auto_install = true,
    highlight = {
      enable = true,
      use_languagetree = true,
      -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is the name of the parser)
      -- list of language that will be disabled
      -- disable = { "c", "rust" },
      -- Or use a function for more flexibility, e.g. to disable slow treesitter highlight for large files
      -- disable = function(lang, buf)
      --     if lang=="tex" then return true end
      --     local max_filesize = 1024 * 1024 -- 1 MiB
      --     local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
      --     if ok and stats and stats.size > max_filesize then
      --         return true
      --     end
      -- end,
      disable={"tex", "latex"},

      -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
      -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
      -- Using this option may slow down your editor, and you may see some duplicate highlights.
      -- Instead of true it can also be a list of languages
      additional_vim_regex_highlighting = false,
    },

    textobjects={
      select={
        enable=true,
        keymaps=mappings.textobjects.select,
        lookahead=true
      },
      move={
        enable=true,
        set_jumps=true,
        goto_next_start=mappings.textobjects.move.goto_next_start,
        goto_previous_start=mappings.textobjects.move.goto_previous_start,
        goto_next_end=mappings.textobjects.move.goto_next_end,
        goto_previous_end=mappings.textobjects.move.goto_previous_end
      },
      swap={
        enable=true,
        swap_next=mappings.textobjects.swap.swap_next,
        swap_previous=mappings.textobjects.swap.swap_previous
      }
    }
  },
  config = function(_, opts)
    require("nvim-treesitter.configs").setup(opts)
  end
}
