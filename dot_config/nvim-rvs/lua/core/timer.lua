return {
  {
    "ravsii/timer.nvim",
    -- dir = "~/dev/OpenSource/timer.nvim/",
    -- dev = true,
    opts = {},
    -- init = function(_, opts)
    --   local module = "timer"
    --   vim.api.nvim_create_autocmd("BufWritePost", {
    --     pattern = vim.fn.expand("~") .. "/dev/OpenSource/timer.nvim/**/*.lua",
    --     callback = function()
    --       package.loaded[module] = nil
    --       require(module).setup(opts)
    --     end,
    --   })
    -- end,
  },
}
