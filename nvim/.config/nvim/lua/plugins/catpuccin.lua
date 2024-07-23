return {
  "catppuccin/nvim",
  name = "catpuccin",
  priority = 1000,
  config = function()
    local catppuccin = require("catppuccin")
    vim.cmd.colorscheme "catppuccin-frappe"
  end
}
