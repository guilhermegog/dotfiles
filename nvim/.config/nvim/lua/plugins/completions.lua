return {
  {
    "hrsh7th/cmp-nvim-lsp",
  },
  {
    "zbirenbaum/copilot-cmp",
    dependencies = {
      "github/copilot.vim",
    },
    config = function()
      require("copilot_cmp").setup({
      })
    end,

  },
  {
    "L3MON4D3/LuaSnip",
    dependencies = {
      "saadparwaiz1/cmp_luasnip",
      "rafamadriz/friendly-snippets",
    },
  },
  {
    "hrsh7th/nvim-cmp",

    config = function()
      local lspkind = require('lspkind')
      lspkind.init({
        symbol_map = {
          Copilot = "",
        },
      })
      local cmp = require("cmp")
      local has_words_before = function()
        if vim.api.nvim_buf_get_option(0, "buftype") == "prompt" then return false end
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_text(0, line - 1, 0, line - 1, col, {})[1]:match("^%s*$") == nil
      end
      require("luasnip.loaders.from_vscode").lazy_load()
      cmp.setup({
        snippet = {
          -- REQUIRED - you must specify a snippet engine
          expand = function(args)
            require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
          end,
        },
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
          ["<Tab>"] = vim.schedule_wrap(function(fallback)
            if cmp.visible() and has_words_before() then
              cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
            else
              fallback()
            end
          end)
        }),
        sources = {
          { name = "copilot",  group_index = 2 },
          { name = 'nvim_lsp', group_index = 2 },
          { name = 'path',     group_index = 2 },
          { name = "luasnip" }, -- For luasnip users.

        },
        {
          { name = "buffer" },
        },

      })
    end,
  },
} -- cmp.lua
