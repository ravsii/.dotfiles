vim.pack.add({
  "https://github.com/keaising/im-select.nvim",
})

require("im_select").setup({
  default_im_select = "com.apple.keylayout.ABC",
  set_default_events = { "VimEnter", "FocusGained", "InsertLeave", "CmdlineLeave" },
  set_previous_events = {},
  async_switch_im = true,
})
