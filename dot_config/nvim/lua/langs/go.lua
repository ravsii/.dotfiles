require("install")
  :add_mason({
    "impl",
    "gofumpt",
    "goimports",
    "gopls",
    "golangci_lint_ls",
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
    dependencies = { "fredrikaverpil/neotest-golang" },
    opts = {
      adapters = {
        ["neotest-golang"] = {
          go_test_args = { "-race", "-count=1" },
          dap_go_enabled = true, -- requires leoluz/nvim-dap-go
        },
      },
    },
  },
  {
    "stevearc/conform.nvim",
    opts = function(_, opts)
      -- formattag should be the first source as it adds extra newline at the
      -- end of the file, thus breaking gofumpt linting
      opts.formatters_by_ft.go = { "formattag", "gofumpt", "goimports" }
      opts.formatters.formattag = {
        command = "formattag",
        stdin = true,
      }
    end,
  },
}
