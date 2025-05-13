return {
  {
    "L3MON4D3/LuaSnip",
    init = function()
      vim.g.lua_snippets_path="./lua/snippets/lua"
      vim.g.snipmate_snippets_path="./lua/snippets/snipmate"
    end,
    cmd = { "LuaSnipListAvailable" },
    lazy = false,
    opts = function()
      local ls = require "luasnip"
      local map = vim.keymap.set
      local opts=function(desc)
        return {noremap = true, silent = true, desc = desc}
      end

      map({"i"}, "<C-Tab>",ls.expand, opts "Expand snippet inline")
      map({"i", "s"}, "<C-l>", function() ls.jump(1) end, opts "Snippet jump forward")
      map({"i", "s"}, "<C-h>", function() ls.jump(-1) end, opts "Snippet jump backward")

      map({"i", "s"}, "<C-n>", function()
        if ls.choice_active() then
          ls.change_choice(1)
        end
      end, opts "Snippet next choice")

      map({"i", "s"}, "<C-p>", function()
        if ls.choice_active() then
          ls.change_choice(-1)
        end
      end, opts "Snippet previous choice")

      require("luasnip.loaders.from_snipmate").lazy_load({paths = vim.g.snipmate_snippets_path})
      require("luasnip.loaders.from_lua").lazy_load({paths = vim.g.lua_snippets_path})

      return {
        enable_autosnippets=true
      }
    end
  }
}
