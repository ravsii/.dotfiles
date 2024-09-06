return {
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, { "gci", "golangci-lint", "golangci-lint-langserver" })
    end,
  },
  {
    "mfussenegger/nvim-lint",
    opts = function(_, opts)
      table.insert(opts.linters_by_ft, {
        go = { "golangcilint" },
      })
    end,
  },
}
