local first_comma_pos, _ = string.find(vim.o.runtimepath, ",")

return string.sub(vim.o.runtimepath, 1, first_comma_pos - 1)
