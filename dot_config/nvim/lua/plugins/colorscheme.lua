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
    "sainnhe/sonokai",
    lazy = false,
    priority = 1000,
    config = function()
      vim.g.sonokai_enable_italic = true
      vim.g.sonokai_style = "atlantis"
      vim.g.sonokai_better_performance = 1
    end,
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "sonokai",
    },
  },
}
