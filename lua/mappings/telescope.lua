local map = vim.keymap.set

map("n", "<leader>R", function() vim.cmd "Telescope resume" end, { desc = "Telescope resume" })
map("n", "<leader>f.", function()
  require("telescope.builtin").find_files({ cwd = require("telescope.utils").buffer_dir() })
end, { desc = "Find in current dir" })

map("n", "<leader>ff", function() vim.cmd "Telescope find_files" end, { desc = "Files" })
map("n", "<leader>fb", function() vim.cmd "Telescope buffers" end, { desc = "Open buffers" })
map("n", "<leader>fc", function() vim.cmd "Telescope commands" end, { desc = "Ex commands" })
map("n", "<leader>fh", function() vim.cmd "Telescope help_tags" end, { desc = "Find help" })
map("n", "<leader>fk", function() vim.cmd "Telescope keymaps" end, { desc = "Keymaps" })
map("n", "<leader>fw", function() vim.cmd "Telescope live_grep" end, { desc = "Live grep" })
map("n", "<leader>fm", function() vim.cmd "Telescope man_pages" end, { desc = "Man pages" })
map("n", "<leader>fr", function() vim.cmd "Telescope reloader" end, { desc = "Reload module" })
map("n", "<leader>ft", function() vim.cmd "Telescope treesitter" end, { desc = "Treesitter" })
map("n", "<leader>fs", function() vim.cmd "Telescope lsp_dynamic_workspace_symbols" end, { desc = "Symbols" })
map("n", "<leader>fz", function() vim.cmd "Telescope current_buffer_fuzzy_find" end, { desc = "Files" })

map("n", "<leader>f*", function() vim.cmd "Telescope grep_string" end, { desc = "Find current word" })

map("n", "<leader>fR", function() vim.cmd "Telescope registers" end, { desc = "Vim registers" })
map("n", "<leader>fJ", function() vim.cmd "Telescope jumplist" end, { desc = "Jumplist" })
map("n", "<leader>fH", function() vim.cmd "Telescope oldfiles" end, { desc = "File history" })
map("n", "<leader>fM", function() vim.cmd "Telescope marks" end, { desc = "Marks" })
map("n", "<leader>fC", function() vim.cmd "Telescope git_commits" end, { desc = "Git commits" })
map("n", "<leader>fS", function() vim.cmd "Telescope git_status" end, { desc = "Git status" })
map("n", "<leader>f<M-s>", function() vim.cmd "Telescope search_history" end, { desc = "Searches" })
map("n", "<leader>fO", function() vim.cmd "Telescope vim_options" end, { desc = "Vim options" })
map("n", "<leader>f<M-h>", function() vim.cmd "Telescope command_history" end, { desc = "Ex command history" })

map("n", "<leader>Cf", function()
  local nvim_home = require "utils.nvim_home"
  require("telescope.builtin").find_files({cwd=nvim_home})
end, { desc = "Find file in config" })
map("n", "<leader>Cw", function()
  local nvim_home = require "utils.nvim_home"
  require("telescope.builtin").live_grep({cwd=nvim_home})
end, { desc = "Find word in config" })

