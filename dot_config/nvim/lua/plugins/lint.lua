return {
  "mfussenegger/nvim-lint",
  opts = function(_, opts)
    table.insert(opts.linters_by_ft, {
      go = { "golangcilint" },
    })
  end,
}
