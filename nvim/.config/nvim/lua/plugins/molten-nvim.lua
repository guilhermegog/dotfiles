return {
  {
    "benlubas/molten-nvim",
    version = "^1.0.0", -- use version <2.0.0 to avoid breaking changes
    build = ":UpdateRemotePlugins",
    init = function()
      -- Configuration options
      vim.g.molten_output_win_max_height = 12
      vim.g.molten_auto_open_output = false
      vim.g.molten_image_provider = "image.nvim"
      vim.g.molten_wrap_output = true
      vim.g.molten_virt_text_output = true
      vim.g.molten_virt_lines_off_by_1 = true

      -- Key mappings
      vim.keymap.set("n", "<leader>mi", ":MoltenInit<CR>", { silent = true, desc = "Initialize Molten" })
      vim.keymap.set(
        "n",
        "<leader>me",
        ":MoltenEvaluateOperator<CR>",
        { silent = true, desc = "Molten run operator selection" }
      )
      vim.keymap.set("n", "<leader>rl", ":MoltenEvaluateLine<CR>", { silent = true, desc = "Molten evaluate line" })
      vim.keymap.set(
        "n",
        "<leader>rr",
        ":MoltenReevaluateCell<CR>",
        { silent = true, desc = "Molten re-evaluate cell" }
      )
      vim.keymap.set(
        "v",
        "<leader>r",
        ":<C-u>MoltenEvaluateVisual<CR>gv",
        { silent = true, desc = "Molten evaluate visual selection" }
      )
      vim.keymap.set(
        "n",
        "<leader>mo",
        ":noautocmd MoltenEnterOutput<CR>",
        { silent = true, desc = "Molten enter output" }
      )
    end,
  },
  {
    -- see the image.nvim readme for more information about configuring this plugin
    "3rd/image.nvim",
    opts = {
      backend = "ueberzug", -- whatever backend you would like to use
      max_width = 100,
      max_height = 12,
      max_height_window_percentage = math.huge,
      max_width_window_percentage = math.huge,
      window_overlap_clear_enabled = true, -- toggles images when windows are overlapped
      window_overlap_clear_ft_ignore = { "cmp_menu", "cmp_docs", "" },
    },
  },
}
