return {
  {
    "akinsho/bufferline.nvim",
    event = "VeryLazy",
    keys = {
      { "<leader>bp", "<Cmd>BufferLineTogglePin<CR>", desc = "Toggle Pin" },
      { "<leader>bP", "<Cmd>BufferLineGroupClose ungrouped<CR>", desc = "Delete Non-Pinned Buffers" },
      { "<leader>br", "<Cmd>BufferLineCloseRight<CR>", desc = "Delete Buffers to the Right" },
      { "<leader>bl", "<Cmd>BufferLineCloseLeft<CR>", desc = "Delete Buffers to the Left" },
      { "<S-h>", "<cmd>BufferLineCyclePrev<cr>", desc = "Prev Buffer" },
      { "<S-l>", "<cmd>BufferLineCycleNext<cr>", desc = "Next Buffer" },
      { "[b", "<cmd>BufferLineCyclePrev<cr>", desc = "Prev Buffer" },
      { "]b", "<cmd>BufferLineCycleNext<cr>", desc = "Next Buffer" },
      { "[B", "<cmd>BufferLineMovePrev<cr>", desc = "Move buffer prev" },
      { "]B", "<cmd>BufferLineMoveNext<cr>", desc = "Move buffer next" },
    },
    opts = function()
      local bufferline = require("bufferline")
      local icons = require("icons")
      local palette = require("rose-pine.palette")

      return {
        options = {
          always_show_bufferline = true,
          indicator = { style = "none" },
          mode = "buffers",
          modified_icon = "●",
          move_wraps_at_ends = true,
          separator_style = { "", "" },
          show_buffer_close_icons = false,
          style_preset = bufferline.style_preset.minimal,
          truncate_names = true,
          tab_size = 1, -- As min as possible
          diagnostics = "nvim_lsp",
          color_icons = true,

          diagnostics_indicator = function(count, level, _, _)
            local icon = level:match("error") and icons.diagIcons.Error or icons.diagIcons.Warning
            return icon .. " " .. count
          end,

          offsets = {
            {
              filetype = "neo-tree",
              text = "Neo-tree",
              highlight = "Directory",
              text_align = "left",
            },
          },
        },
        highlights = {
          buffer_selected = {
            fg = palette.foam,
          },
        },
      }
    end,
  },
}
