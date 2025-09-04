return {
  {
    "stevearc/oil.nvim",
    ---@module 'oil'
    ---@type oil.SetupOpts
    opts = {
      default_file_explorer = false,
      delete_to_trash = true,
      columns = {
        "icon",
        -- "permissions",
        -- "size",
        -- "mtime",
      },
      float = {
        padding = 0,
        max_width = 0.8,
        max_height = 0.8,
        border = "rounded",
      },
    },
    dependencies = {
      { "echasnovski/mini.icons", opts = {} },
    },
    keys = {
      -- Main
      {
        "<leader>o",
        function()
          require("oil").open_float()
        end,
        desc = "Open Oil",
      },
      {
        "<leader>o",
        function()
          require("oil").close()
        end,
        ft = "oil",
        desc = "Open Oil",
      },
    },
  },
}
