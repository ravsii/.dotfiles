return {
  { "LuaCATS/luassert", name = "luassert-types", lazy = true },
  { "LuaCATS/busted", name = "busted-types", lazy = true },
  {
    "folke/lazydev.nvim",
    ft = "lua",
    opts = {
      library = {
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
        { path = "busted-types/library", words = { "describe" } },
        { path = "luassert-types/library", words = { "assert" } },
        { path = "snacks.nvim", words = { "Snacks" } },
      },
    },
  },
}
