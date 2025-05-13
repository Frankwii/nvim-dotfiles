return {
  {
    "neovim/nvim-lspconfig",
    init = function() require "mappings.lsp" end,
    event = { "BufReadPre", "BufNewFile" },
    dependencies = { "hrsh7th/cmp-nvim-lsp" }
  },
  {
    "hrsh7th/cmp-nvim-lsp",
    lazy = true,
    opts = function()
    local default_capabilities = require("cmp_nvim_lsp").default_capabilities()

    for lsp, config in pairs(vim.g.servers_and_configs) do
      vim.lsp.enable(lsp)

      config.capabilities = config.capabilities or default_capabilities
      vim.lsp.config(lsp, {
        settings = {
          [lsp] = config
        }
      })
    end
  end
  },
  {
    "hrsh7th/nvim-cmp",
    event = { "InsertEnter", "CmdlineEnter" },
    lazy = true,
    dependencies = {
      "hrsh7th/cmp-buffer",     -- source for text in buffer
      "hrsh7th/cmp-path",       -- source for file system paths
      "hrsh7th/cmp-nvim-lsp",
      -- TODO: Add nvim-cmp as a dependency for luasnip!
      -- "L3MON4D3/LuaSnip",       -- snippet engine
      -- "saadparwaiz1/cmp_luasnip", -- for autocompletion
      "hrsh7th/cmp-cmdline",
      "petertriho/cmp-git",
      "f3fora/cmp-spell",
    },
    opts = function()
      local cmp = require "cmp"

      local kind_icons = {
        article = "󰧮",
        book = "",
        incollection = "󱓷",
        Function = "󰊕",
        Constructor = "",
        Text = "󰦨",
        Method = "",
        Field = "󰅪",
        Variable = "󱃮",
        Class = "",
        Interface = "",
        Module = "",
        Property = "",
        Unit = "",
        Value = "󰚯",
        Enum = "",
        Keyword = "",
        Snippet = "",
        -- Color = "󰌁",
        Color = "",
        File = "",
        Reference = "",
        Folder = "",
        EnumMember = "",
        spell = "",
        -- EnumMember = "",
        Constant = "󰀫",
        -- Struct = "",
        Struct = "",
        Event = "",
        Operator = "󰘧",
        TypeParameter = "",
      }

      return {

        completion = {
          keyword_length = 2,
        },
        snippet = {     -- configure how nvim-cmp interacts with snippet engine
          expand = function(args)
            local luasnip = require "luasnip"
            luasnip.lsp_expand(args.body)
          end,
        },

        mapping = cmp.mapping.preset.insert({
            ["<C-k>"] = cmp.mapping(cmp.mapping.select_prev_item(), { "i", "c" }),
            ["<C-j>"] = cmp.mapping(cmp.mapping.select_next_item(), { "i", "c" }),
            ["<C-Down>"] = cmp.mapping.scroll_docs(-4),
            ["<C-Up>"] = cmp.mapping.scroll_docs(4),
            ["<C-n>"] = cmp.mapping.complete(), -- show completion suggestions
            ["<C-h>"] = cmp.mapping.abort(), -- close completion window
            ["<C-l>"] = cmp.mapping.confirm({ select = false }),
            ['<CR>'] = cmp.mapping(function(fallback)
              if cmp.visible() then
                if cmp.get_selected_entry() then
                  cmp.confirm({ select = false })
                else
                  cmp.close()
                  fallback()
                end
              else
                fallback()
              end
            end, { 'i', 's' }),
            ["<C-CR>"] = cmp.mapping.confirm({ select = true }),
            ["<C-Space>"] = cmp.mapping.confirm({ select = true }),
            ["<Tab>"] = cmp.mapping(function(fallback)
              if cmp.visible() then
                cmp.select_next_item()
              else
                fallback()
              end
            end, { "i", "s" }),
            ["<S-Tab>"] = cmp.mapping(function(fallback)
              if cmp.visible() then
                cmp.select_prev_item()
              else
                fallback()
              end
            end, { "i", "s" }),
        }),
        -- formatting for autocompletion
        formatting = {
          expandable_indicator = false,
          fields = { "kind", "abbr", "menu" },
          format = function(entry, vim_item)
            vim_item.kind = string.format("%s", kind_icons[vim_item.kind])     -- Kind icons
            vim_item.menu = ({
              -- vimtex = (vim_item.menu ~= nil and vim_item.menu or "[VimTex]"),
              -- vimtex = test_fn(vim_item.menu, entry.source.name),
              -- vimtex = vim_item.menu,
              luasnip = "[Snippet]",
              nvim_lsp = "[LSP]",
              buffer = "[Buffer]",
              spell = "[Spell]",
              -- orgmode = "[Org]",
              -- latex_symbols = "[Symbols]",
              cmdline = "[CMD]",
              path = "[Path]",
            })[entry.source.name]
            return vim_item
          end,
        },
        -- matching={
        --   disallow_fuzzy_matching = false,
        -- },
        -- sources for autocompletion
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "luasnip" },     -- snippets
          -- { name = "vimtex" },
          -- { name = "orgmode" },
          -- { name = "pandoc" },
          { name = "omni" },
          { name = "buffer" },    -- text within current buffer
          {
            name = "spell",
            keyword_length = 4,
            option = {
              keep_all_entries = false,
            },
          },
          { name = "path" },
        }),
        confirm_opts = {
          behavior = cmp.ConfirmBehavior.Replace,
          select = false,
        },
        view = {
          docs={auto_open=true},
          entries = 'custom',
        },
        window = {
          completion = {
            border = { "╔", "═" ,"╗", "║", "╝", "═", "╚", "║"},
            scrollbar=true,
          },
          documentation = {
            border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
          },
        },
      }
    end
  },
}
