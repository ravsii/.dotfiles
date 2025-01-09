local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
parser_config.d2 = {
  install_info = {
    url = "~/dev/OpenSource/tree-sitter-d2",
    files = { "src/parser.c" },
    requires_generate_from_grammar = true,
  },
  filetype = "d2",
}

parser_config.d2p = {
  install_info = {
    url = "https://git.pleshevski.ru/pleshevskiy/tree-sitter-d2",
    revision = "main",
    files = { "src/parser.c", "src/scanner.c" },
    requires_generate_from_grammar = true,
  },
}

vim.filetype.add({
  extension = {
    d2 = "d2",
  },
})

return {}
