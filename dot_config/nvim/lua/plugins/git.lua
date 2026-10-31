vim.pack.add({
  "https://github.com/lewis6991/gitsigns.nvim",
  "https://github.com/spacedentist/resolve.nvim",
})

require("gitsigns").setup({
  current_line_blame = true,
  current_line_blame_opts = {
    delay = 0,
  },
  max_file_length = 10000,
})

vim.keymap.set("n", "<leader>gb", "<cmd>Gitsigns blame<cr>", { desc = "Git Blame" })
vim.keymap.set("n", "<leader>ghs", "<cmd>Gitsigns stage_hunk<cr>", { desc = "Stage/Unstage Hunk" })
vim.keymap.set(
  "x",
  "<leader>ghs",
  function() require("gitsigns").stage_hunk({ vim.fn.line("."), vim.fn.line("v") }) end,
  { desc = "Stage/Unstage Selected Hunk" }
)
vim.keymap.set("n", "<leader>ghr", "<cmd>Gitsigns reset_hunk<cr>", { desc = "Reset Hunk" })
vim.keymap.set(
  "x",
  "<leader>ghr",
  function() require("gitsigns").reset_hunk({ vim.fn.line("."), vim.fn.line("v") }) end,
  { desc = "Reset Selected Hunk" }
)
vim.keymap.set("n", "<leader>ghi", "<cmd>Gitsigns preview_hunk_inline<cr>", { desc = "Preview Hunk Inline" })
vim.keymap.set("n", "<leader>ghh", "<cmd>Gitsigns preview_hunk<cr>", { desc = "Preview Hunk Popup" })
vim.keymap.set("n", "]h", "<cmd>Gitsigns nav_hunk next<cr>", { desc = "Next Hunk" })
vim.keymap.set("n", "[h", "<cmd>Gitsigns nav_hunk prev<cr>", { desc = "Previous Hunk" })

local conflict_keys = {
  { "]x", "<cmd>ResolveNext<cr>", "Next conflict" },
  { "[x", "<cmd>ResolvePrev<cr>", "Previous conflict" },
  { "<leader>gco", "<cmd>ResolveOurs<cr>", "Choose ours" },
  { "<leader>gct", "<cmd>ResolveTheirs<cr>", "Choose theirs" },
  { "<leader>gcb", "<cmd>ResolveBoth<cr>", "Choose both" },
  { "<leader>gcB", "<cmd>ResolveBothReverse<cr>", "Choose both (reverse)" },
  { "<leader>gcm", "<cmd>ResolveBase<cr>", "Choose base" },
  { "<leader>gcn", "<cmd>ResolveNone<cr>", "Choose none" },
  { "<leader>gcl", "<cmd>ResolveList<cr>", "List conflicts" },
  { "<leader>gcdo", "<cmd>ResolveDiffOurs<cr>", "Diff ours" },
  { "<leader>gcdt", "<cmd>ResolveDiffTheirs<cr>", "Diff theirs" },
  { "<leader>gcdb", "<cmd>ResolveDiffBoth<cr>", "Diff both" },
  { "<leader>gcdv", "<cmd>ResolveDiffOursTheirs<cr>", "Diff ours vs theirs" },
  { "<leader>gcdV", "<cmd>ResolveDiffTheirsOurs<cr>", "Diff theirs vs ours" },
}

require("resolve").setup({ default_keymaps = false })

require("which-key").add({
  { "<leader>gc", group = "Git Conflicts", mode = "n" },
  { "<leader>gcd", group = "Diff", mode = "n" },
  { "<leader>gh", group = "hunks", mode = { "n", "x" } },
})

for _, key in ipairs(conflict_keys) do
  vim.keymap.set("n", key[1], key[2], { desc = key[3] })
end
