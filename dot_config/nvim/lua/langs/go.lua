require("install")
  :add_mason({
    "gofumpt",
    "delve",
    "goimports",
    "golangci-lint",
    "golangci_lint_ls",
    "gopls",
    "impl",
    "gci",
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
    dependencies = {
      { "mason-org/mason.nvim", opts = { ensure_installed = { "delve" } } },
      { "leoluz/nvim-dap-go", opts = {} },
    },
  },
  {
    "nvim-neotest/neotest",
    version = "*",
    dependencies = {
      {
        "fredrikaverpil/neotest-golang",
        version = "*",
        build = function()
          vim.system({ "go", "install", "gotest.tools/gotestsum@latest" }):wait() -- Optional, but recommended
        end,
      },
    },
    config = function(_, opts)
      local neotest_golang_opts = {
        -- https://fredrikaverpil.github.io/neotest-golang/config/
        runner = "gotestsum",
        go_test_args = { "-race" },
        dap_go_enabled = true, -- requires leoluz/nvim-dap-go
        warn_test_name_dupes = false,
        testify_enabled = false,
        colorize_test_output = true,
      }

      opts.adapters = { require("neotest-golang")(neotest_golang_opts) }
      require("neotest").setup(opts)
    end,
  },
  {
    "stevearc/conform.nvim",
    opts = function(_, opts)
      -- formattag should be the first source as it adds extra newline at the
      -- end of the file, thus breaking gofumpt linting
      opts.formatters_by_ft.go = { "goimports", "gci", "formattag", "gofumpt" }
      opts.formatters.gci = {
        command = "gci",
        stdin = true,
        args = {
          "print",
          "--custom-order",
          "--section",
          "standard",
          "--section",
          "default",
        },
      }

      opts.formatters.formattag = {
        command = "formattag",
        stdin = true,
      }
    end,
  },
}
