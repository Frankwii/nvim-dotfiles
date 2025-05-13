local M={}

M.textobjects={}
M.textobjects.select={
  ["af"] = "@function.outer",
  ["if"] = "@function.inner",
  ["ak"] = "@class.outer",
  ["ik"] = "@class.inner",
  ["ac"] = "@conditional.outer",
  ["ic"] = "@conditional.inner",
  ["al"] = "@loop.outer",
  ["il"] = "@loop.inner",
  ["ap"] = "@parameter.outer",
  ["ip"] = "@parameter.inner",
  ["a<C-b>"] = "@block.outer",
  ["i<C-b>"] = "@block.inner"
}

M.textobjects.move = {
  goto_next_start = {
    ["mf"] = "@function.outer",
    ["mc"] = "@conditional.outer",
    ["mk"] = "@class.outer",
    ["ml"] = "@loop.outer",
    ["mp"] = "@parameter.outer",
    ["mb"] = "@block.inner",
  },

  goto_previous_start = {
    ["Mf"] = "@function.outer",
    ["Mc"] = "@conditional.outer",
    ["Mk"] = "@class.outer",
    ["Ml"] = "@loop.outer",
    ["Mp"] = "@parameter.outer",
    ["Mb"] = "@block.inner",
  },

  goto_next_end = {
    ["ñf"] = "@function.outer",
    ["ñc"] = "@conditional.outer",
    ["ñk"] = "@class.outer",
    ["ñl"] = "@loop.outer",
    ["ñp"] = "@parameter.outer",
    ["ñb"] = "@block.inner",
  },

  goto_previous_end = {
    ["Ñf"] = "@function.outer",
    ["Ñc"] = "@conditional.outer",
    ["Ñk"] = "@class.outer",
    ["Ñl"] = "@loop.outer",
    ["Ñp"] = "@parameter.outer",
    ["Ñb"] = "@block.inner",
  },
}

M.textobjects.swap = {
  swap_next = {
    ["<leader>Sfj"] = "@function.outer",
    ["<leader>Skj"] = "@class.outer",
    ["<leader>Scj"] = "@conditional.outer",
    ["<leader>Slj"] = "@loop.outer",
    ["<leader>Spj"] = "@parameter.inner",
    ["<leader>S<C-b>j"] = "@block.outer",
  },
  swap_previous = {
    ["<leader>Sfk"] = "@function.outer",
    ["<leader>Skk"] = "@class.outer",
    ["<leader>Sck"] = "@conditional.outer",
    ["<leader>Slk"] = "@loop.outer",
    ["<leader>Spk"] = "@parameter.inner",
    ["<leader>S<C-b>k"] = "@block.outer",
  }
}

-- vim.keymap.set('n', '<C-t>', function()
--   local function see(x)
--     vim.print(vim.inspect(x))
--   end
--
--           -- (typed_parameter ; [20, 23] - [20, 45]
--           --   (identifier) ; [20, 23] - [20, 39]
--           --   type: (type ; [20, 41] - [20, 45]
--           --     (identifier)))) ; [20, 41] - [20, 45]
--   local query = vim.treesitter.query.parse('python', [[
--     ; ((typed_parameter) (identifier) type: (type (identifier)))
--     (typed_parameter (identifier))
--   ]])
--   local root = vim.treesitter.get_parser():parse()[1]:root()
--
--   for id, node, metadata in query:iter_captures(root, 0) do
--     see(id)
--     see(node)
--     see(metadata)
--
--   end
-- end)

return M
