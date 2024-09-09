return {
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
}
