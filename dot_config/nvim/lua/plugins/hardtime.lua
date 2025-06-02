return {
  {
    "m4xshen/hardtime.nvim",
    lazy = false,
    dependencies = { "MunifTanjim/nui.nvim" },
    opts = {},
    init = function()
      local ht_enabled = true

      ---@module "snacks"
      require("snacks").toggle
        .new({
          id = "hardtime_nvim",
          name = "Hardtime.nvim",
          get = function()
            return ht_enabled
          end,
          set = function()
            vim.cmd(":Hardtime toggle")
            ht_enabled = not ht_enabled
          end,
        })
        :map("<leader>uH")
    end,
  },
}
