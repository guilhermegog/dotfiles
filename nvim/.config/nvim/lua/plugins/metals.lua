return {
  "scalameta/nvim-metals",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  ft = { "scala", "sbt", "java" },
  opts = function()
    local metals_config = require("metals").bare_config()
    metals_config.on_attach = function(client, bufnr)
      -- your on_attach function
      local function buf_set_keymap(...)
        vim.api.nvim_buf_set_keymap(bufnr, ...)
      end
      buf_set_keymap("n", "K", vim.lsp.buf.hover, {})
      buf_set_keymap("n", "gD", '<cmd>Telescope lsp_declaration<CR>', {})
      buf_set_keymap("n", "gd", '<cmd>Telescope lsp_definition<CR>', {})
      buf_set_keymap("n", "gr", '<cmd>Telescope lsp_references<CR>', {})
      buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', {})
      buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', {})
      buf_set_keymap({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, {})
    end

    return metals_config
  end,
  config = function(self, metals_config)
    local nvim_metals_group = vim.api.nvim_create_augroup("nvim-metals", { clear = true })
    vim.api.nvim_create_autocmd("FileType", {
      pattern = self.ft,
      callback = function()
        require("metals").initialize_or_attach(metals_config)
      end,
      group = nvim_metals_group,
    })
  end
}
