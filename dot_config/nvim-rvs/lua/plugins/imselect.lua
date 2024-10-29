return {
  "keaising/im-select.nvim",
  opts = {
    -- IM will be set to `default_im_select` in `normal` mode
    -- For Windows/WSL, default: "1033", aka: English US Keyboard
    -- For macOS, default: "com.apple.keylayout.ABC", aka: US
    -- For Linux, default:
    --               "keyboard-us" for Fcitx5
    --               "1" for Fcitx
    --               "xkb:us::eng" for ibus
    default_im_select = "com.apple.keylayout.ABC",
    default_command = "im-select",
    set_default_events = { "VimEnter", "FocusGained", "InsertLeave", "CmdlineLeave" },
    set_previous_events = {},
    async_switch_im = true,
  },
}
