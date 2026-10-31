-- Go
local before_init = vim.lsp.config.golangci_lint_ls.before_init

vim.lsp.config("golangci_lint_ls", {
  before_init = function(params, config)
    -- Сохраняем штатный выбор аргументов для версии golangci-lint.
    if before_init then before_init(params, config) end

    if not config.root_dir then return end
    local root = vim.fs.root(config.root_dir, { ".golangci.pipeline.yaml" })
    if not root then return end

    -- Аргументы конкретного проекта не должны попадать в другие клиенты.
    config.init_options.command = vim.deepcopy(config.init_options.command)
    table.insert(config.init_options.command, "--config=" .. root .. "/.golangci.pipeline.yaml")
  end,
})
