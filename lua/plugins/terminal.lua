return {
	"akinsho/toggleterm.nvim",
	cmd = { "ToggleTerm", "TermExec" },
  lazy = true,
	keys = {
		{
			"<M-f>",
			function()
				vim.cmd("ToggleTerm direction=float")
			end,
			mode = { "n", "t" },
    },
    {
      "<M-CR>",
      function()
        vim.cmd("ToggleTerm size=12 direction=horizontal")
      end,
      mode = { "n", "t" },
		},
    {
      "<M-q>",
      function()
        vim.cmd("ToggleTerm")
      end,
      mode = { "t" },
		},
	},
  opts = {
    shade_terminals = false
  }
}
