local list = {
  "3rd/image.nvim",
  "catppuccin/nvim",
  "folke/flash.nvim",
  "folke/noice.nvim",
  "folke/persistence.nvim",
  -- "folke/trouble.nvim",
  "lewis6991/gitsigns.nvim",
  "nvimdev/dashboard-nvim",
  -- "rcarriga/nvim-notify",
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
