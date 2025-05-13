vim.g.nonconflicting_hydra_keymap = "ñññ"

local options = {
-- GENERAL
  swapfile = false,
  undofile = true,
  writebackup = false,
  clipboard = "unnamedplus", -- make nvim use the same clipboard as the system (not local)

-- APPEARANCE
  cmdheight=0,
  wrap = true,
  number = true,
  relativenumber = true,
  numberwidth = 2,
  cursorline = true,
  termguicolors=true,

-- INDENT
  tabstop = 2,                    -- insert 2 spaces for a tab
  shiftwidth = 2,                 -- the number of spaces inserted for each indentation
  softtabstop = 2,                -- insert 2 spaces for a tab
  expandtab = true,               -- convert tabs to spaces
  breakindent = true,             -- tab wrapped lines
  linebreak = true,               -- companion to wrap, don't split words
  backspace = "indent,eol,start", -- allow backspace on indent, end of line or insert mode start position
  scrolloff = 2,
}

for key,value in pairs(options) do
  vim.o[key] = value
end

-- Let's try this for a bit to move through snake_case
vim.opt.iskeyword:remove {"_"}
