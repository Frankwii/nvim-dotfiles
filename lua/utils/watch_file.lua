local watch_automcd_group = "WATCH_FILES"

local M = {}

M.open_and_watch_file = function(path, callback)
	--- callback(bufnr) -> None

	-- Create file if it doesn't exist. Could probably make this into a module of its own
	if ~vim.fs.exists(path) then
		vim.fn.writefile({}, path, "w")
	end

	vim.cmd.edit(path)
	local bufnr = vim.fn.bufnr("%")

  vim.api.nvim_create_autocmd(
    {'BufWritePost'},
    {
      buffer = bufnr,
      callback = function(args) callback(args.buf) end,
      group = watch_automcd_group,
      desc = "Watching buffer " .. bufnr
    }
  )
end

return M
