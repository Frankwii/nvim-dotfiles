--- Define filetype-specific mappings
-- Specify functionality here and metadata (key mappings, description, etc.)
-- Inside the "functionalities" table below.
local filetype_specific_mappings = {
  python={
    run=function()
      local filepath = vim.fn.expand('%:p')
      local cmd = "python " .. "\"" .. filepath .. "\""

      require("utils.termexec")(cmd)
    end
  },
  tex = {
    compile="<cmd>VimtexCompile<cr>"
  }
}

local functionalities = {
  run={
    mode="n",
    lhs="<leader>ra",
    opts={desc="Run all"}
  },
  compile={
    mode="n",
    lhs="<C-c><C-a>",
    opts={desc="Compile"}
  }
}

-- Mappings that do not make sense for more than one language
local specifics = {
  tex = {
    {
      mode='',
      lhs="<C-LeftMouse>",
      rhs="<LeftMouse><cmd>VimtexView<cr>",
      opts={noremap=true, silent=true, desc="View in pdf editor"}
    }
  }
}

for lang, cmds in pairs(filetype_specific_mappings) do
  for functionality, specs in pairs(functionalities) do
    if cmds[functionality] ~= nil then
      vim.api.nvim_create_autocmd("FileType", {pattern=lang, callback=function()
        vim.keymap.set(specs["mode"], specs["lhs"], cmds[functionality], specs["opts"])
      end})
    end
  end
end

for lang, cmds in pairs(specifics) do
  for _, specs in ipairs(cmds) do
    vim.api.nvim_create_autocmd("FileType", {pattern=lang, callback=function()
      vim.keymap.set(specs.mode, specs.lhs, specs.rhs, specs.opts)
    end})
  end
end
