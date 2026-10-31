local M = {}

---Run a plugin's hook after it is installed or updated by vim.pack.
---@param name string Plugin name from the PackChanged event
---@param callback fun(data: vim.event.packchanged.data) Receives the event data
function M.on_change(name, callback)
  vim.api.nvim_create_autocmd("PackChanged", {
    callback = function(event)
      if event.data.spec.name ~= name then return end
      if event.data.kind ~= "install" and event.data.kind ~= "update" then return end
      callback(event.data)
    end,
  })
end

return M
