local list = {
  "MeanderingProgrammer/render-markdown.nvim",
  "catppuccin/nvim",
  "folke/noice.nvim",
  "folke/persistence.nvim",
  "lewis6991/gitsigns.nvim",
  "theHamsta/nvim-dap-virtual-text",
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
