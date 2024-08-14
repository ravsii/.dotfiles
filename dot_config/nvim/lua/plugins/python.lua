vim.g.lazyvim_python_lsp = "pyright"
vim.g.lazyvim_python_ruff = "ruff_lsp"

return {
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      table.insert(opts.ensure_installed, "black")
      table.insert(opts.ensure_installed, "isort")
    end,
  },
  {
    "stevearc/conform.nvim",
    opts = function(_, opts)
      opts.formatters_by_ft.python = { "black", "isort" }
      opts.formatters.black = {
        args = {
          "--stdin-filename",
          "$FILENAME",
          "--quiet",
          "--line-length",
          "90",
          "--skip-string-normalization",
          "-",
        },
      }
    end,
  },
  -- {
  --   "linux-cultist/venv-selector.nvim",
  --   branch = "regexp", -- This is the regexp branch, use this for the new version
  -- },
}
