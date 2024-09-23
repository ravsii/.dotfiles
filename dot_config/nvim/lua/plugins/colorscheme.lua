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
    "projekt0n/github-nvim-theme",
    lazy = false, -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
      require("github-theme").setup({
        -- ...
      })
    end,
  },
  {
    "rose-pine/neovim",
    name = "rose-pine",
    config = function()
      require("rose-pine").setup({
        variant = "moon", -- auto, main, moon, or dawn
        dark_variant = "moon", -- main, moon, or dawn
        dim_inactive_windows = false,
        extend_background_behind_borders = true,

        enable = {
          terminal = true,
          legacy_highlights = false, -- Improve compatibility for previous versions of Neovim
          migrations = true, -- Handle deprecated options automatically
        },

        styles = {
          bold = true,
          italic = true,
          transparency = false,
        },
      })
    end,
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "rose-pine",
    },
  },
}
