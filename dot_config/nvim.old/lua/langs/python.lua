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
  {
    "linux-cultist/venv-selector.nvim",
    dependencies = { "neovim/nvim-lspconfig", "nvim-telescope/telescope.nvim", "mfussenegger/nvim-dap-python" },
    opts = {},
    event = "VeryLazy", -- Optional: needed only if you want to type `:VenvSelect` without a keymapping
    keys = {
      { "<leader>cv", "<cmd>VenvSelect<cr>", desc = "Select .venv" },
    },
  },
}
