local list = {
  "catppuccin/nvim",
  "folke/persistence.nvim",
  -- "folke/trouble.nvim",
  "folke/noice.nvim",
  "theHamsta/nvim-dap-virtual-text",
  "MeanderingProgrammer/render-markdown.nvim",
}

-- @returns table[]
local disable = function()
  local tbl = {}
  for _, plugin in ipairs(list) do
    table.insert(tbl, { plugin, enabled = false })
  end
  return tbl
end

return disable()
