require("install")
  :add_mason({
    "gci",
    "impl",
    "gofumpt",
    "goimports",
    "gomodifytags",
    "golangci-lint",
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
      opts.formatters_by_ft.go = { "gofumpt", "formattag", "goimports", "gci" }
      opts.formatters.formattag = {
        command = "formattag",
        stdin = true,
      }
      opts.formatters.gci = {
        command = "gci",
        stdin = true,
        args = {
          "print",
          "--custom-order",
          "--section",
          "standard",
          "--section",
          "localmodule",
          "--section",
          "default",
        },
      }
    end,
  },
  -- {
  --   "neovim/nvim-lspconfig",
  --   opts = {
  --     servers = {
  --       gopls = {
  --         settings = {
  --           gopls = {
  --             gofumpt = true,
  --             codelenses = {
  --               gc_details = true,
  --               generate = true,
  --               regenerate_cgo = true,
  --               run_govulncheck = true,
  --               test = true,
  --               tidy = true,
  --               upgrade_dependency = true,
  --               vendor = true,
  --             },
  --             hints = {
  --               assignVariableTypes = true,
  --               compositeLiteralFields = true,
  --               compositeLiteralTypes = true,
  --               constantValues = true,
  --               functionTypeParameters = true,
  --               parameterNames = true,
  --               rangeVariableTypes = true,
  --             },
  --             analyses = {
  --               nilness = true,
  --               unusedparams = true,
  --               unusedwrite = true,
  --               useany = true,
  --               fieldalignment = false,
  --               composites = false,
  --             },
  --             usePlaceholders = false,
  --             completeUnimported = true,
  --             staticcheck = true,
  --             directoryFilters = { "-.git", "-.vscode", "-.idea", "-.vscode-test", "-node_modules" },
  --             semanticTokens = true,
  --           },
  --         },
  --       },
  --     },
  --   },
  -- },
}
