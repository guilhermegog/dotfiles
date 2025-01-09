return {
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "lua_ls",
          "bashls",
          "clangd",
          "dockerls",
          "jsonls",
          "markdown_oxide",
          "pylsp",
          "rust_analyzer",
          "verible",
          "cmake",
          "taplo",
        },
      })
    end,
  },

  {
    "neovim/nvim-lspconfig",
    config = function()
      local capabilities = require("cmp_nvim_lsp").default_capabilities()
      local lspconfig = require("lspconfig")
      lspconfig.lua_ls.setup({
        capabilities = capabilities,
      })
      lspconfig.bashls.setup({
        capabilities = capabilities,
      })
      lspconfig.clangd.setup({
        capabilities = capabilities,
      })
      lspconfig.dockerls.setup({
        capabilities = capabilities,
      })
      lspconfig.jsonls.setup({
        capabilities = capabilities,
      })
      lspconfig.markdown_oxide.setup({
        capabilities = capabilities,
      })
      require 'lspconfig'.pylsp.setup {
        pylsp = {
        settings = {
          pylsp = {
            plugins = {
              pylint = {args = {'--ignore=E501,E231', '-'}, enabled=true, debounce=200},
              pycodestyle = {
                enabled = false,
                ignore = { 'W391', 'E501', 'E231' },
                maxLineLength = 120
              }
            }
          }
        }
        }
      }
      lspconfig.rust_analyzer.setup({
        capabilities = capabilities,
      })
      lspconfig.verible.setup({
        capabilities = capabilities,
      })
      lspconfig.cmake.setup({
        capabilities = capabilities,
      })
      lspconfig.taplo.setup({
        capabilities = capabilities,
      })
      vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
      vim.keymap.set("n", "gD", '<cmd>Telescope lsp_type_definitions<CR>', {})
      vim.keymap.set("n", "gd", '<cmd>Telescope lsp_definitions<CR>', {})
      vim.keymap.set("n", "gr", '<cmd>Telescope lsp_references<CR>', {})
      vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, {})
      vim.keymap.set('n', ']d', vim.diagnostic.goto_next, {})
      vim.keymap.set('n', '<leader>e', function()
        -- If we find a floating window, close it.
        local found_float = false
        for _, win in ipairs(vim.api.nvim_list_wins()) do
          if vim.api.nvim_win_get_config(win).relative ~= '' then
            vim.api.nvim_win_close(win, true)
            found_float = true
          end
        end
        if found_float then
          return
        end

        vim.diagnostic.open_float(nil, { focus = false, scope = 'cursor' })
      end, { desc = 'Toggle Diagnostics' })
      vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, {})
    end,
  },
}
