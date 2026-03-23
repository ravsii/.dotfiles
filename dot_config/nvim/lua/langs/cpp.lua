require("install")
  :add_mason({
    "clangd",
    "cmake",
    "clang-format",
    "codelldb",
  })
  :add_treesitter({ "cpp" })

return {}
