return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = {
      close_if_last_window = true,
      filesystem = {
        filtered_items = {
          hide_dotfiles = false,
          hide_by_name = {
            ".git",
          },
        },
      },
    },
  },
  {
    "akinsho/bufferline.nvim",
    opts = function(_, opts)
      local bufferline = require("bufferline")
      opts.options.mode = "buffers"
      opts.options.style_preset = bufferline.style_preset.no_bold
      opts.options.separator_style = "thick"
      opts.options.always_show_bufferline = false
      opts.options.show_buffer_close_icons = false
    end,
  },
  {
    "rcarriga/nvim-notify",
    opts = {
      stages = "static",
      render = "minimal",
    },
  },
}
