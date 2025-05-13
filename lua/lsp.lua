for type, icon in pairs({ Error = "", Warn = "", Hint = "󰠠", Info = "" }) do
	local hl = "DiagnosticSign" .. type
	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end

local servers_and_configs = {
	pyright = {},
	lua_ls = {},
	clangd = {},
	bashls = {},
	tsserver = {},
}

vim.g.servers_and_configs = servers_and_configs

for lsp, config in pairs(servers_and_configs) do
	vim.lsp.enable(lsp)

	vim.lsp.config(lsp, {
		settings = {
			[lsp] = config,
		},
	})
end
