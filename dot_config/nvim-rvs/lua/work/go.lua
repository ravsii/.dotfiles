return {
  {
    "stevearc/conform.nvim",
    opts = function(_, opts)
      opts.formatters.gci.args = {
        "print",
        "--custom-order",
        "--section",
        "standard",
        "--section",
        "localmodule",
        "--section",
        "prefix(gitlab.rutube.ru)",
        "--section",
        "default",
      }
    end,
  },
}
