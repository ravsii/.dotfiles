local M = {}

M.lsp = {}
M.treesitter = {}
M.lsp_enable_exclude = {}

--- Add one or more LSP servers
--- @param servers string[]
--- @return table self
function M:add_mason(servers)
  assert(type(servers) == "table", "add_mason expects a table of strings")
  vim.list_extend(self.lsp, servers)
  return self
end

--- Add one or more Treesitter parsers
--- @param parsers string[]
--- @return table self
function M:add_treesitter(parsers)
  assert(type(parsers) == "table", "add_treesitter expects a table of strings")
  vim.list_extend(self.treesitter, parsers)
  return self
end

--- Add one or more LSP servers to the automatic_enable.exclude list
--- @param servers string[]
--- @return table self
function M:add_lsp_enable_exclude(servers)
  assert(type(servers) == "table", "add_lsp_enable_exclude expects a table of strings")
  vim.list_extend(self.lsp_enable_exclude, servers)
  return self
end

return M
