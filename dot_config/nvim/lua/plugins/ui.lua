return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = {
      close_if_last_window = true,
      filesystem = {
        filtered_items = {
          hide_dotfiles = false,
          hide_by_name = {
            ".git",
          },
        },
      },
    },
  },
  {
    "rcarriga/nvim-notify",
    opts = {
      stages = "static",
      render = "minimal",
    },
    {
      "folke/noice.nvim",
      optional = true,
      opts = {
        presets = {
          inc_rename = {
            cmdline = {
              format = {
                IncRename = {
                  pattern = "^:%s*IncRename%s*",
                  icon = " ",
                  conceal = true,
                  opts = {
                    relative = "cursor",
                    size = { min_width = 20 },
                    position = { row = -3, col = 0 },
                  },
                },
              },
            },
          },
        },
      },
    },
  },
}
