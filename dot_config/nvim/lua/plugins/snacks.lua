return {
  {
    "folke/snacks.nvim",

  -- stylua: ignore
  keys = {
    { "<leader><space>", LazyVim.pick("files", { root = false }), desc = "Find Files (cwd)" },
  },

    ---@module "snacks"
    ---@type snacks.Config
    opts = {
      ---@class snacks.scroll.Config
      scroll = {
        enabled = false,
      },

      ---@class snacks.gitbrowse.Config
      gitbrowse = {
        url_patterns = {
          ["gitlab%.ru"] = {
            branch = "/-/tree/{branch}",
            file = "/-/blob/{branch}/{file}#L{line_start}-L{line_end}",
            commit = "/-/commit/{commit}",
          },
        },
      },

      ---@class snacks.picker.files.Config: snacks.picker.proc.Config
      picker = {
        hidden = true,
        ignored = true,
        supports_live = true,
      },
    },
  },
}
