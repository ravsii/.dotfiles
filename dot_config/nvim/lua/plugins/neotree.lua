return {
  "nvim-neo-tree/neo-tree.nvim",
  init = function() end, -- Disable neo-tree open on startup
  opts = {
    close_if_last_window = true,
    filesystem = {
      filtered_items = {
        hide_dotfiles = false,
        hide_by_name = {
          ".git",
        },
      },
    },
  },
}
