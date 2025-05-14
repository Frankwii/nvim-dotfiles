require("options")
require("lsp")
require("lazynvim")
require("mappings.global")
require("autocmds")

vim.g.colorscheme = "catppuccin"
require("utils.changecolorscheme")(vim.g.colorscheme)
