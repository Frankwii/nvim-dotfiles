require("options")
require("lsp")
require("lazynvim")
require("mappings.global")

vim.g.colorscheme = "catppuccin"
require("utils.changecolorscheme")(vim.g.colorscheme)
