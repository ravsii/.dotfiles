require("install")
  :add_mason({
    "clangd",
    "clang-format",
    "codelldb",
  })
  :add_treesitter({ "cpp" })

return {}
