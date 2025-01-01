return {
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      style = "storm",
      terminal_colors = true,
      lualine_bold = true,
      hide_inactive_statusline = true,
      transparent = false,
      styles = {
        sidebars = "transparent",
        floats = "transparent",
        comments = { italic = true },
        keywords = { bold = true },
      },

      ---@param colors ColorScheme
      on_colors = function(colors) end,

      ---@param highlights Highlights
      ---@param colors ColorScheme
      on_highlights = function(highlights, colors)
        highlights.DiffAdd.fg = colors.green
        highlights.DiffDelete = {
          bg = colors.red1,
        }
      end,
    },
  },
  {
    "rose-pine/neovim",
    name = "rose-pine",
    opts = {
      variant = "moon",
    },
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "rose-pine",
    },
  },
}
