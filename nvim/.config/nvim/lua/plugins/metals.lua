return {
  "scalameta/nvim-metals",
  dependencies = {
    {
      "nvim-lua/plenary.nvim",
    },
    {
      "hrsh7th/nvim-cmp",
      event = "InsertEnter",
      dependencies = {
        { "hrsh7th/cmp-nvim-lsp" },
        { "hrsh7th/cmp-vsnip" },
        { "hrsh7th/vim-vsnip" }
      },
      opts = function()
        local fn = vim.fn
        local cmp = require("cmp")
        local conf = {
          sources = {
            { name = "nvim_lsp" },
            { name = "vsnip" },
          },
          snippet = {
            expand = function(args)
              -- Comes from vsnip
              fn["vsnip#anonymous"](args.body)
            end,
          },
          mapping = cmp.mapping.preset.insert({
            -- None of this made sense to me when first looking into this since there
            -- is no vim docs, but you can't have select = true here _unless_ you are
            -- also using the snippet stuff. So keep in mind that if you remove
            -- snippets you need to remove this select
            ["<CR>"] = cmp.mapping.confirm({ select = true })
          })
        }
        return conf
      end
    },
    {
      "j-hui/fidget.nvim",
      opts = {}
    },

    {
      "mfussenegger/nvim-dap",
      config = function(self, opts)
        -- Debug settings if you're using nvim-dap
        local dap = require("dap")

        dap.configurations.scala = {
          {
            type = "scala",
            request = "launch",
            name = "RunOrTest",
            metals = {
              runType = "runOrTestFile",
              --args = { "firstArg", "secondArg", "thirdArg" }, -- here just as an example
            },
          },
          {
            type = "scala",
            request = "launch",
            name = "Test Target",
            metals = {
              runType = "testTarget",
            },
          },
        }
      end
    },
  },

  ft = { "scala", "sbt", "java" },
  opts = function()
    local metals_config = require("metals").bare_config()
    -- Example of settings
    metals_config.settings = {
      showImplicitArguments = true,
      excludedPackages = { "akka.actor.typed.javadsl", "com.github.swagger.akka.javadsl" },
    }

    -- *READ THIS*
    -- I *highly* recommend setting statusBarProvider to either "off" or "on"
    --
    -- "off" will enable LSP progress notifications by Metals and you'll need
    -- to ensure you have a plugin like fidget.nvim installed to handle them.
    --
    -- "on" will enable the custom Metals status extension and you *have* to have
    -- a have settings to capture this in your statusline or else you'll not see
    -- any messages from metals. There is more info in the help docs about this
    metals_config.init_options.statusBarProvider = "off"

    -- Example if you are using cmp how to make sure the correct capabilities for snippets are set
    metals_config.capabilities = require("cmp_nvim_lsp").default_capabilities()

    metals_config.on_attach = function(client, bufnr)
      -- your on_attach function
      require("metals").setup_dap()
      -- LSP mappings
      local map = vim.keymap.set
      map("n", "gD", '<cmd>Telescope lsp_definitions<CR>', {})
      map("n", "gd", vim.lsp.buf.declaration)
      map("n", "K", vim.lsp.buf.hover, {})
      map("n", "gr", '<cmd>Telescope lsp_references<CR>')
      map("n", "[d", vim.diagnostic.goto_prev)
      map("n", "]d", vim.diagnostic.goto_next)
      map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action)
      map("n", "<leader>cl", vim.lsp.codelens.run)
      map("n", "<leader>rn", vim.lsp.buf.rename)
      map("n", "<leader>ws", function()
        require("metals").hover_worksheet()
      end)
      map("n", "<leader>mc", function()
        require("telescope").extensions.metals.commands()
      end)

      map("n", "<leader>dc", function()
        require("dap").continue()
      end)

      map("n", "<leader>dr", function()
        require("dap").repl.toggle()
      end)

      map("n", "<leader>dK", function()
        require("dap.ui.widgets").hover()
      end)

      map("n", "<leader>dt", function()
        require("dap").toggle_breakpoint()
      end)

      map("n", "<leader>dso", function()
        require("dap").step_over()
      end)

      map("n", "<leader>dsi", function()
        require("dap").step_into()
      end)

      map("n", "<leader>dl", function()
        require("dap").run_last()
      end)
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
