return {
  'kevinhwang91/nvim-ufo',
  dependencies = { 'kevinhwang91/promise-async' },
  --    event = 'VeryLazy',   -- You can make it lazy-loaded via VeryLazy, but comment out if thing doesn't work
  init = function()
    vim.o.foldlevel = 99
    vim.o.foldlevelstart = 99
    vim.o.foldenable = true
    vim.o.foldcolumn = '1'

    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities.textDocument.foldingRange = {
      dynamicRegistration = false,
      lineFoldingOnly = true
    }
    local language_servers = require("lspconfig").util.available_servers() -- or list servers manually like {'gopls', 'clangd'}
    for _, ls in ipairs(language_servers) do
      require('lspconfig')[ls].setup({
        capabilities = capabilities
      })
    end
  end,
  config = function()
    require('ufo').setup({
      open_fold_hl_timeout = 150,
      close_fold_kinds_for_ft = {
        default = { 'imports', 'comment' },
        json = { 'array' },
        c = { 'comment', 'region' }
      },
      preview = {
        win_config = {
          border = { '', '─', '', '', '', '─', '', '' },
          winhighlight = 'Normal:Folded',
          winblend = 0
        },
        mappings = {
          scrollU = '<C-u>',
          scrollD = '<C-d>',
          jumpTop = '[',
          jumpBot = ']'
        }
      }
    })
    -- zo and az open and close current folds respecitvely
    vim.keymap.set('n', 'zR', require("ufo").openAllFolds)
    vim.keymap.set('n', 'zM', require("ufo").closeAllFolds)
    vim.keymap.set('n', 'zr', require("ufo").openFoldsExceptKinds)
    vim.keymap.set('n', 'zm', require("ufo").closeFoldsWith)
    vim.keymap.set('n', 'K', function()
      local winid = require('ufo').peekFoldedLinesUnderCursor()
      if not winid then
        vim.lsp.buf.hover()
      end
    end)
  end,
}
