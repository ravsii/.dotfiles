vim.pack.add({
  "https://github.com/stevearc/conform.nvim",
})

require("conform").setup({
  default_format_opts = {
    timeout_ms = 3000,
    async = false,
    quiet = false,
    lsp_format = "fallback",
  },
  formatters_by_ft = {
    -- Lua
    lua = { "stylua" },
    -- Go
    go = { "goimports", "gci", "formattag", "gofumpt" },
    -- Shell
    sh = { "shfmt" },
    -- Markdown
    markdown = { "markdown-toc" },
    ["markdown.mdx"] = { "markdown-toc" },
  },
  formatters = {
    injected = { options = { ignore_errors = true } },
    -- Go
    gci = {
      command = "gci",
      stdin = true,
      args = { "print", "--custom-order", "--section", "standard", "--section", "default" },
    },
    formattag = { command = "formattag", stdin = true },
  },
})

vim.keymap.set({ "n", "v" }, "<leader>cf", function() require("conform").format({ timeout_ms = 3000 }) end, { desc = "Format" })
vim.keymap.set(
  { "n", "v" },
  "<leader>cF",
  function() require("conform").format({ formatters = { "injected" }, timeout_ms = 3000 }) end,
  { desc = "Format Injected Langs" }
)

vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*",
  callback = function(args) require("conform").format({ bufnr = args.buf }) end,
})
