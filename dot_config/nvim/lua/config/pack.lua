-- vim.pack
vim.keymap.set("n", "<leader>pu", function() vim.pack.update() end, { desc = "Update plugins" })
vim.keymap.set("n", "<leader>pl", function()
  vim.print(
    vim
      .iter(vim.pack.get(nil, { info = false }))
      :filter(function(plugin) return plugin.active end)
      :map(function(plugin) return plugin.spec.name end)
      :totable()
  )
end, { desc = "List plugins" })

vim.keymap.set("n", "<leader>pd", function()
  local plugins = vim.pack.get(nil, { info = false })
  if #plugins == 0 then
    vim.notify("No plugins to delete", vim.log.levels.INFO)
    return
  end

  table.sort(plugins, function(a, b) return a.spec.name < b.spec.name end)
  vim.ui.select(plugins, {
    prompt = "Delete plugin:",
    format_item = function(plugin)
      return plugin.spec.name .. (plugin.active and " (active)" or " (inactive)")
    end,
  }, function(plugin)
    if not plugin then return end
    vim.pack.del({ plugin.spec.name }, { force = plugin.active })
  end)
end, { desc = "Delete plugin" })
