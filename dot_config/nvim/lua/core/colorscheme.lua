-- set the theme in lazy.lua

return {
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    ---@module "tokyonight"
    ---@class tokyonight.Config
    opts = {
      style = "storm",
      light_style = "day", -- The theme is used when the background is set to light
      transparent = true,
      terminal_colors = true,
      styles = {
        -- Background styles. Can be "dark", "transparent" or "normal"
        sidebars = "transparent", -- style for sidebars, see below
        floats = "transparent", -- style for floating windows
      },
      dim_inactive = true, -- dims inactive windows
      lualine_bold = true, -- When `true`, section headers in the lualine theme will be bold
    },
  },
  {
    "rose-pine/neovim",
    name = "rose-pine",
    priority = 1000,
    opts = {
      variant = "moon",
      styles = { transparency = true },
    },
    init = function() vim.cmd([[colorscheme rose-pine]]) end,
  },
}
