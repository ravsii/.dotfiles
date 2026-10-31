vim.pack.add({
  "https://github.com/chentoast/marks.nvim",
})

vim.api.nvim_set_hl(0, "MarkSignHL", { link = "@character" })
require("marks").setup({})
