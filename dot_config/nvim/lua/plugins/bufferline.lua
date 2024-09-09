return {
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
}
