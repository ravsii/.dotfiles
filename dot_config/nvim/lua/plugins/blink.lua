vim.pack.add({
  "https://github.com/saghen/blink.lib",
  "https://github.com/rafamadriz/friendly-snippets",
  "https://github.com/saghen/blink.cmp",
})

vim.opt.autocomplete = false

local blink = require("blink.cmp")
vim.lsp.config("*", { capabilities = blink.get_lsp_capabilities() })

blink.setup({
  keymap = {
    preset = "enter",
    ["<C-y>"] = { "select_and_accept" },
  },
  appearance = {
    nerd_font_variant = "mono",
    kind_icons = {
      Class = "",
      Color = "",
      Constant = "",
      Constructor = "",
      Enum = "",
      EnumMember = "",
      Event = "",
      Field = "",
      File = "",
      Folder = "",
      Function = "󰊕",
      Interface = "",
      Keyword = "",
      Method = "ƒ",
      Module = "󰏗",
      Property = "",
      Snippet = "",
      Struct = "",
      Text = "",
      Unit = "",
      Value = "",
      Variable = "",
    },
  },
  completion = {
    documentation = { auto_show = true },
    trigger = { show_on_insert_on_trigger_character = false },
    list = { selection = { preselect = true, auto_insert = false } },
    ghost_text = { enabled = true },
    menu = {
      draw = {
        columns = {
          { "label", "label_description" },
          { "kind_icon", "kind", gap = 1 },
        },
      },
    },
  },
  sources = {
    default = { "lsp", "path", "snippets", "buffer" },
    providers = {
      snippets = {
        opts = {
          friendly_snippets = true,
          search_paths = { vim.fn.stdpath("config") .. "/snippets" },
        },
      },
    },
  },
  fuzzy = { implementation = "lua" },
  signature = { enabled = true },
})
