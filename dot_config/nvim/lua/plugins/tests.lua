vim.pack.add({
  "https://github.com/nvim-lua/plenary.nvim",
  "https://github.com/nvim-neotest/nvim-nio",
  "https://github.com/nvim-neotest/neotest",
  "https://github.com/fredrikaverpil/neotest-golang",
  "https://github.com/andythigpen/nvim-coverage",
})

require("neotest").setup({
  adapters = {
    require("neotest-golang")({
      runner = "gotestsum",
      go_test_args = { "-race" },
      dap_mode = "dap-go",
      warn_test_name_dupes = false,
      testify_enabled = true,
      colorize_test_output = true,
    }),
  },
  status = { virtual_text = true },
  output = { open_on_run = false },
  quickfix = { open = false },
})

require("coverage").setup({
  auto_reload = true,
  signs = {
    covered = { text = "+" },
    uncovered = { text = "-" },
    partial = { text = "~" },
  },
})

require("which-key").add({
  { "<leader>t", group = "test", mode = "n" },
  { "<leader>tc", group = "coverage", mode = "n" },
})

vim.keymap.set(
  "n",
  "<leader>tt",
  function() require("neotest").run.run(vim.fn.expand("%")) end,
  { desc = "Run File (Neotest)" }
)
vim.keymap.set(
  "n",
  "<leader>tT",
  function() require("neotest").run.run(vim.uv.cwd()) end,
  { desc = "Run All Test Files (Neotest)" }
)
vim.keymap.set("n", "<leader>tr", function() require("neotest").run.run() end, { desc = "Run Nearest (Neotest)" })
vim.keymap.set("n", "<leader>tl", function() require("neotest").run.run_last() end, { desc = "Run Last (Neotest)" })
vim.keymap.set(
  "n",
  "<leader>ts",
  function() require("neotest").summary.toggle() end,
  { desc = "Toggle Summary (Neotest)" }
)
vim.keymap.set(
  "n",
  "<leader>to",
  function() require("neotest").output.open({ enter = true, auto_close = true }) end,
  { desc = "Show Output (Neotest)" }
)
vim.keymap.set(
  "n",
  "<leader>tO",
  function() require("neotest").output_panel.toggle() end,
  { desc = "Toggle Output Panel (Neotest)" }
)
vim.keymap.set("n", "<leader>tS", function() require("neotest").run.stop() end, { desc = "Stop (Neotest)" })
vim.keymap.set(
  "n",
  "<leader>tw",
  function() require("neotest").watch.toggle(vim.fn.expand("%")) end,
  { desc = "Toggle Watch (Neotest)" }
)

vim.keymap.set("n", "<leader>tcc", "<cmd>Coverage<cr>", { desc = "Show coverage" })
vim.keymap.set("n", "<leader>tcC", function()
  local path = vim.fn.input("Enter coverage path: ")
  if path == "" then
    vim.cmd("Coverage")
    return
  end
  vim.cmd("Coverage " .. vim.fn.fnameescape(path))
end, { desc = "Show coverage (input path)" })
vim.keymap.set("n", "<leader>tcs", "<cmd>CoverageShow<cr>", { desc = "Show coverage signs" })
vim.keymap.set("n", "<leader>tch", "<cmd>CoverageHide<cr>", { desc = "Hide coverage signs" })
vim.keymap.set("n", "<leader>tct", "<cmd>CoverageToggle<cr>", { desc = "Toggle coverage signs" })
vim.keymap.set("n", "<leader>tcd", "<cmd>CoverageClear<cr>", { desc = "Delete coverage cache" })
vim.keymap.set("n", "<leader>tcm", "<cmd>CoverageSummary<cr>", { desc = "Coverage summary" })
