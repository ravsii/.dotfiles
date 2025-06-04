return {
  "nvim-treesitter/nvim-treesitter",
  lazy = false,
  branch = "master",
  build = ":TSUpdate",
  opts = {
    textobjects = {
      swap = {
        enable = true,
        swap_previous = {
          ["H"] = "@parameter.inner",
        },
        swap_next = {
          ["L"] = "@parameter.inner",
        },
      },
    },
  },
}
