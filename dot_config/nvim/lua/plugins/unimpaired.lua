return {
  {
    "tummetott/unimpaired.nvim",
    -- I randomly found this behaviour in Helix, and it's really life-changing
    opts = {
      keymaps = {
        blank_above = {
          mapping = "[<Space>",
          description = "Add [count] blank lines above",
          dot_repeat = true,
        },
        blank_below = {
          mapping = "]<Space>",
          description = "Add [count] blank lines below",
          dot_repeat = true,
        },
      },
    },
  },
}
