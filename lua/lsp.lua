vim.diagnostic.config({
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = "",
			[vim.diagnostic.severity.WARN] = "",
			[vim.diagnostic.severity.HINT] = "󰠠",
			[vim.diagnostic.severity.INFO] = "",
		},
	},
})

local servers_and_configs = {
	basedpyright = {
		cmd = { "basedpyright-langserver", "--stdio" },
		filetypes = { "python" },
		root_markers = {
			"pyproject.toml",
			"setup.py",
			"setup.cfg",
			"requirements.txt",
			"Pipfile",
			"pyrightconfig.json",
			".git",
		},
		settings = {
      basedpyright = {
        analysis = {
          diagnosticMode = "workspace",
        },
      },
    },
	},
	lua_ls = {},
	clangd = {},
	bashls = {},
	ts_ls = {},
}

local blink = require("blink.cmp")
local default_config = {
  capabilities = blink.get_lsp_capabilities(),
  root_markers = {".git"}
}

vim.g.servers_and_configs = servers_and_configs

for server, config in pairs(servers_and_configs) do

  local conf = vim.tbl_extend("keep", config, default_config)

	vim.lsp.config(server, conf)

	vim.lsp.enable(server)
end
