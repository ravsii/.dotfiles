return {
  {
    "mistricky/codesnap.nvim",
    build = "make",
    opts = {
      mac_window_bar = true,
      title = "",
      code_font_family = "CaskaydiaCove Nerd Font",
      watermark_font_family = "Pacifico",
      watermark = "",
      bg_theme = "grape",
      breadcrumbs_separator = "/",
      has_breadcrumbs = true,
      has_line_number = false,
      show_workspace = false,
      min_width = 0,
      bg_x_padding = 75,
      bg_y_padding = 25,
      save_path = os.getenv("XDG_PICTURES_DIR") or (os.getenv("HOME") .. "/Pictures"),
    },
    keys = {
      { "<leader>cs", "<cmd>CodeSnap<cr>", mode = "x", desc = "Code Snapshot into Clipboard" },
    },
  },
}
