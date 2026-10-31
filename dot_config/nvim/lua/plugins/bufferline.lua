vim.pack.add({
  "https://github.com/akinsho/bufferline.nvim",
})

local bufferline = require("bufferline")
local palette = require("rose-pine.palette")

bufferline.setup({
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
    tab_size = 1,
    diagnostics = "nvim_lsp",
    color_icons = true,
    diagnostics_indicator = function(count, level)
      local icon = level:match("error") and "" or ""
      return icon .. " " .. count
    end,
    offsets = {
      {
        filetype = "fyler_finder",
        text = "Fyler",
        highlight = "Directory",
        text_align = "left",
      },
    },
  },
  highlights = {
    buffer_selected = { fg = palette.foam },
  },
})

vim.keymap.set("n", "<leader>bp", "<Cmd>BufferLineTogglePin<CR>", { desc = "Toggle Pin" })
vim.keymap.set("n", "<leader>br", "<Cmd>BufferLineCloseRight<CR>", { desc = "Delete Buffers to the Right" })
vim.keymap.set("n", "<leader>bl", "<Cmd>BufferLineCloseLeft<CR>", { desc = "Delete Buffers to the Left" })
vim.keymap.set("n", "<S-h>", "<Cmd>BufferLineCyclePrev<CR>", { desc = "Prev Buffer" })
vim.keymap.set("n", "<S-l>", "<Cmd>BufferLineCycleNext<CR>", { desc = "Next Buffer" })
vim.keymap.set("n", "[b", "<Cmd>BufferLineMovePrev<CR>", { desc = "Move buffer prev" })
vim.keymap.set("n", "]b", "<Cmd>BufferLineMoveNext<CR>", { desc = "Move buffer next" })
