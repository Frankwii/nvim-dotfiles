return {
  "yssl/QFEnter",
  init = function ()
    vim.g.qfenter_autoclose = true
    vim.g.qfenter_keymap = {
      open = {"<CR>"},
      vopen = {"<M-s>"},
      hopen = {"<M-t>"},
      topen = {"T"}
    }
  end,
  event = "FileType qf"
}
