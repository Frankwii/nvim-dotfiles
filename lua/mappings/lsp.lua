local map = vim.keymap.set
vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    local function opts(desc)
      return { noremap = true, silent = true, buffer = args.buf, desc = "LSP " .. desc }
    end

    map("n", "<leader>Wa", vim.lsp.buf.add_workspace_folder, opts "Add workspace folder")
    map("n", "<leader>Wr", vim.lsp.buf.remove_workspace_folder, opts "Remove workspace folder")

    map("n", "<leader>Wl", function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, opts "List workspace folders")

    map("n", "<leader>cD", vim.lsp.buf.declaration, opts "Go to declaration")
    map("n", "<leader>cd", vim.lsp.buf.definition, opts "Go to definition")


    map("n", "<leader>ct", vim.lsp.buf.type_definition, opts "Go to type definition")
    map("n", "<leader>cr", vim.lsp.buf.rename, opts "Rename symbol")

    -- Show References
    map("n", "<leader>cf", vim.lsp.buf.references, opts "Where is this used")

    -- Code Actions
    map("n", "<leader>ca", vim.lsp.buf.code_action, opts "Code action")

    map("n", "<leader>co", vim.diagnostic.open_float, opts "Open diagnostics")

    map("n", "<leader>cF", vim.lsp.buf.format, opts "Format")
  end
})
