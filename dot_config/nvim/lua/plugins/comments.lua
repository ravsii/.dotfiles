vim.pack.add({
  "https://github.com/folke/ts-comments.nvim",
  "https://github.com/nvim-lua/plenary.nvim",
  "https://github.com/folke/todo-comments.nvim",
})

require("ts-comments").setup()
require("todo-comments").setup()

vim.keymap.set("n", "<leader>st", function() Snacks.picker.todo_comments() end, { desc = "TODO comments" })
