return function(cmd)
  vim.cmd("TermExec cmd=\""..cmd.."\"")
end
