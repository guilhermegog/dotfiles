return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
  },
  config = function()
     vim.keymap.set("n", "<c-b>", ":Neotree toggle<cr>")
   vim.keymap.set("n", "<c-n>", ":Neotree filesystem reveal left<cr>")
  end,
}
