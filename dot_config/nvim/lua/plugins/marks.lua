return {
  {
    "chentoast/marks.nvim",
    event = "VeryLazy",
    opts = {},
    init = function() vim.api.nvim_set_hl(0, "MarkSignHL", { link = "@character" }) end,
  },
}
