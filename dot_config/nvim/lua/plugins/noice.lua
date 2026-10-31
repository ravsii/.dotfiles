vim.pack.add({
  "https://github.com/MunifTanjim/nui.nvim",
  "https://github.com/folke/noice.nvim",
})

require("noice").setup({
  cmdline = { enabled = true, view = "cmdline_popup" },
  views = {
    cmdline_popup = {
      position = { row = "10%", col = "50%" },
      border = { style = "rounded" },
    },
  },
  messages = { enabled = false },
  notify = { enabled = false },
  lsp = {
    hover = { enabled = false },
    signature = { enabled = false },
    progress = { enabled = false },
    message = { enabled = false },
  },
})
