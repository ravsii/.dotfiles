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
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        gopls = {
          settings = {
            gopls = {
              analyses = {
                fieldalignment = false, -- doesnt help, just spams with warnings
                composites = false, -- sane mongodb development
              },
              usePlaceholders = false,
            },
          },
        },
      },
    },
  },
}
