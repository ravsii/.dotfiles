vim.pack.add({
  "https://github.com/gbprod/yanky.nvim",
})

require("yanky").setup({ highlight = { timer = 150 } })

vim.keymap.set({ "n", "x" }, "<leader>P", function() vim.cmd("YankyRingHistory") end, { desc = "Open Yank History" })

for _, key in ipairs({
  { "y", "<Plug>(YankyYank)", "Yank Text", { "n", "x" } },
  { "p", "<Plug>(YankyPutAfter)", "Put Text After Cursor", { "n", "x" } },
  { "P", "<Plug>(YankyPutBefore)", "Put Text Before Cursor", { "n", "x" } },
  { "gp", "<Plug>(YankyGPutAfter)", "Put Text After Selection", { "n", "x" } },
  { "gP", "<Plug>(YankyGPutBefore)", "Put Text Before Selection", { "n", "x" } },
  { "[y", "<Plug>(YankyCycleForward)", "Cycle Forward Through Yank History" },
  { "]y", "<Plug>(YankyCycleBackward)", "Cycle Backward Through Yank History" },
  { "]p", "<Plug>(YankyPutIndentAfterLinewise)", "Put Indented After Cursor (Linewise)" },
  { "[p", "<Plug>(YankyPutIndentBeforeLinewise)", "Put Indented Before Cursor (Linewise)" },
  { "]P", "<Plug>(YankyPutIndentAfterLinewise)", "Put Indented After Cursor (Linewise)" },
  { "[P", "<Plug>(YankyPutIndentBeforeLinewise)", "Put Indented Before Cursor (Linewise)" },
  { ">p", "<Plug>(YankyPutIndentAfterShiftRight)", "Put and Indent Right" },
  { "<p", "<Plug>(YankyPutIndentAfterShiftLeft)", "Put and Indent Left" },
  { ">P", "<Plug>(YankyPutIndentBeforeShiftRight)", "Put Before and Indent Right" },
  { "<P", "<Plug>(YankyPutIndentBeforeShiftLeft)", "Put Before and Indent Left" },
}) do
  vim.keymap.set(key[4] or "n", key[1], key[2], { desc = key[3], remap = true })
end
