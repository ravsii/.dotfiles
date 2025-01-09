local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
parser_config.d2 = {
  install_info = {
    url = "~/dev/OpenSource/tree-sitter-d2",
    files = { "src/parser.c" },
    requires_generate_from_grammar = true,
  },
  filetype = "d2",
}

vim.filetype.add({
  extension = {
    d2 = "d2",
  },
})

return {}
