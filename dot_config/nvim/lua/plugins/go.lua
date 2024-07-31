return {
  -- {
  --   "williamboman/mason.nvim",
  --   opts = function(_, opts)
  --     opts.ensure_installed = opts.ensure_installed or {}
  --     vim.list_extend(opts.ensure_installed, { "goimports-reviser" })
  --   end,
  -- },
  {
    "stevearc/conform.nvim",
    opts = function(_, opts)
      -- formattag should be the first source as it adds extra newline at the
      -- end of the file, thus breaking gofumpt linting
      opts.formatters_by_ft.go = { "gofumpt", "formattag", "goimports" }
      opts.formatters.formattag = {
        command = "formattag",
        stdin = true,
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
