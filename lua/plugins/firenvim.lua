return {
  'glacambre/firenvim',
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
		"neovim/nvim-lspconfig",
  },
  init = function()
    vim.g.firenvim_config = {
      globalSettings = {
        alt = "all"
      },
      localSettings = {
        [".*"] = {
          cmdline = "neovim",
          content = "text",
          priority = 0,
          selector = "textarea",
          takeover = "never"
        }
      }
    }

    vim.api.nvim_create_autocmd({'BufEnter'}, {
      pattern = "github.com_*.txt",
      command = "set filetype=markdown"
    })

    vim.api.nvim_create_autocmd({'BufEnter'}, {
      pattern = "www.boot.dev_*.txt",
      callback = function()
        vim.cmd("set filetype=typescript")
        vim.cmd("LspStart")
      end
    })
  end,
  build = ":call firenvim#install(0)",
}
