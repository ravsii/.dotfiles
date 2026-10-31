-- Search and replace across files with an interactive preview.
vim.pack.add({
  "https://github.com/MagicDuck/grug-far.nvim",
})

require("grug-far").setup({ headerMaxWidth = 80 })

vim.keymap.set("n", "<leader>sr", function()
  local ext = vim.bo.buftype == "" and vim.fn.expand("%:e")
  require("grug-far").open({
    transient = true,
    prefills = {
      filesFilter = ext and ext ~= "" and "*." .. ext or nil,
    },
  })
end, { desc = "Search and Replace" })
