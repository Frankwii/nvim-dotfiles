require("options")
require("lazynvim")
require("lsp")
require("mappings.global")
require("autocmds")

vim.g.colorscheme = "catppuccin"
require("utils.changecolorscheme")(vim.g.colorscheme)
