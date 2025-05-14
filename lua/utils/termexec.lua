return function(cmd)
  vim.cmd("TermExec cmd=clear")
  vim.cmd("TermExec cmd=" .. vim.fn.shellescape(cmd))
end
