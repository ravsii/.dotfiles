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
          ["<M-h>"] = "@parameter.inner",
        },
        swap_next = {
          ["<M-l>"] = "@parameter.inner",
        },
      },
    },
  },
}
