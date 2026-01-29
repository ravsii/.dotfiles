require("install")
  :add_mason({
    "gofumpt",
    "delve",
    "goimports",
    "golangci-lint",
    "golangci_lint_ls",
    "gopls",
    "impl",
  })
  :add_treesitter({ "go", "gomod", "gowork", "gosum" })

vim.lsp.config.gopls = {
  settings = {
    gopls = { analyses = { composites = false, fieldalignment = false } },
  },
}


return {
  {
    "mfussenegger/nvim-dap",
    optional = true,
    dependencies = {
      { "mason-org/mason.nvim", opts = { ensure_installed = { "delve" } } },
      { "leoluz/nvim-dap-go", opts = {} },
    },
  },
  {
    "nvim-neotest/neotest",
    optional = true,
    dependencies = { "fredrikaverpil/neotest-golang", tag = "v1.15.1" },
    opts = {
      adapters = {
        ["neotest-golang"] = {
          go_test_args = { "-race", "-count=1" },
          dap_go_enabled = true, -- requires leoluz/nvim-dap-go
          warn_test_name_dupes = false,
        },
      },
    },
  },
  {
    "stevearc/conform.nvim",
    opts = function(_, opts)
      -- formattag should be the first source as it adds extra newline at the
      -- end of the file, thus breaking gofumpt linting
      opts.formatters_by_ft.go = { "goimports", "formattag", "gofumpt" }
      opts.formatters.formattag = {
        command = "formattag",
        stdin = true,
      }
    end,
  },
}
