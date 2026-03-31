-- Ozon specific settings
local root = vim.fs.root(0, { ".golangci.pipeline.yaml" })

if root then
  table.insert(vim.lsp.config.golangci_lint_ls.init_options.command, "--config=" .. root .. "/.golangci.pipeline.yaml")

  vim.api.nvim_create_autocmd("FileType", {
    pattern = "yaml",
    callback = function()
      vim.bo.shiftwidth = 4
      vim.bo.tabstop = 4
    end,
  })

  return {
    {
      "stevearc/conform.nvim",
      opts = function(_, opts)
        opts.formatters.gci.args = {
          "print",
          "--custom-order",
          "--section",
          "standard",
          "--section",
          "default",
        }
      end,
    },
  }
end

return {}
