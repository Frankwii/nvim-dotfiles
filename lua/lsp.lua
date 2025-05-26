vim.diagnostic.config({
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = "",
			[vim.diagnostic.severity.WARN]  = "",
      [vim.diagnostic.severity.HINT]  = "󰠠",
      [vim.diagnostic.severity.INFO]  = ""
		},
	},
})

local servers_and_configs = {
	pyright = {
		-- analysis = {
		--   diagnosticMode = "workspace",
		--   typeCheckingMode = "strict"
		-- }
	},
	lua_ls = {},
	clangd = {},
	bashls = {},
	ts_ls = {},
}

vim.g.servers_and_configs = servers_and_configs

for server, config in pairs(servers_and_configs) do
	local blink = require("blink.cmp")

	vim.lsp.config(server, {
		root_markers = { ".git" },
		settings = {
			[server] = config,
		},
		capabilities = blink.get_lsp_capabilities({}),
	})

	vim.lsp.enable(server)
end
