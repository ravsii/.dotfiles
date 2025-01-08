return {
  {
    "stevearc/oil.nvim",
    ---@module 'oil'
    ---@type oil.SetupOpts
    opts = {},
    dependencies = { { "echasnovski/mini.icons", opts = {} } },
    keys = {
      { "<leader>o", "<Cmd>Oil<CR>", desc = "Open Oil" },
    },
  },
}
