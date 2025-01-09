local list = {
  "MeanderingProgrammer/render-markdown.nvim",
  "catppuccin/nvim",
  "folke/flash.nvim",
  "folke/noice.nvim",
  "folke/persistence.nvim",
  "theHamsta/nvim-dap-virtual-text",
  -- "folke/trouble.nvim",
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
