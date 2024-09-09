local list = {
  "catppuccin/nvim",
  "folke/flash.nvim",
  "folke/noice.nvim",
  "folke/persistence.nvim",
  "folke/trouble.nvim",
  "nvimdev/dashboard-nvim",
  "lewis6991/gitsigns.nvim",
  -- "rcarriga/nvim-notify",
  "3rd/image.nvim",
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
