require("install"):add_mason({ "shfmt" })

return {
  {
    "stevearc/conform.nvim",
    opts = function(_, opts) opts.formatters_by_ft.sh = { "shfmt" } end,
  },
}
