return {
  "akinsho/bufferline.nvim",
  opts = function(_, opts)
    local bufferline = require("bufferline")
    opts.options.mode = "buffers"
    opts.options.style_preset = bufferline.style_preset.default
    opts.options.separator_style = "slope"
    opts.options.always_show_bufferline = true
    opts.options.show_buffer_close_icons = false
    opts.options.indicator = { style = "underline" }

    return opts
  end,
}
