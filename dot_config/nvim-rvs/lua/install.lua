local M = {}

M.lsp = {}
M.treesitter = {}
M.lsp_enable_exclude = {}
M.linters_by_ft = {}

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
  assert(
    type(servers) == "table",
    "add_lsp_enable_exclude expects a table of strings"
  )
  vim.list_extend(self.lsp_enable_exclude, servers)
  return self
end

--- Add linters by filetype, merging with existing ones
--- @param linters table<string, string[]>
--- @return table self
function M:add_linters_by_ft(linters)
  assert(
    type(linters) == "table",
    "add_linters_by_ft expects a table mapping filetype to list of linters"
  )
  for ft, l in pairs(linters) do
    assert(
      type(l) == "table",
      ("linters for '%s' must be a table of strings"):format(ft)
    )
    M.linters_by_ft[ft] = M.linters_by_ft[ft] or {}
    vim.list_extend(M.linters_by_ft[ft], l)
  end
  return self
end

return M
