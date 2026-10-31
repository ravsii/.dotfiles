vim.pack.add({
  "https://github.com/rose-pine/neovim",
  "https://github.com/folke/tokyonight.nvim",
})

require("rose-pine").setup({
  variant = "moon",
  styles = { transparency = true },
})

---@diagnostic disable-next-line: missing-fields
require("tokyonight").setup({
  style = "storm",
  light_style = "day",
  transparent = true,
  terminal_colors = true,
  styles = {
    sidebars = "transparent",
    floats = "transparent",
  },
  dim_inactive = true,
  lualine_bold = true,
})

vim.cmd.colorscheme("rose-pine")
