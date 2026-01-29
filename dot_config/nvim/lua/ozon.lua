-- Ozon specific settings
local root = vim.fs.root(0, { ".golangci.pipeline.yaml" })

if root then
  table.insert(vim.lsp.config.golangci_lint_ls.init_options.command, "--config=" .. root .. "/.golangci.pipeline.yaml")
end
