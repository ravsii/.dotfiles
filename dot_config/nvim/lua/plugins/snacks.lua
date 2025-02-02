return {
  {
    "folke/snacks.nvim",
    ---@type snacks.Config
    opts = {
      ---@class snacks.scroll.Config
      ---@field animate snacks.animate.Config
      scroll = {
        enabled = false,
      },

      ---@class snacks.gitbrowse.Config
      ---@field url_patterns? table<string, table<string, string|fun(fields:snacks.gitbrowse.Fields):string>>
      gitbrowse = {
        url_patterns = {
          ["gitlab%.ru"] = {
            branch = "/-/tree/{branch}",
            file = "/-/blob/{branch}/{file}#L{line_start}-L{line_end}",
            commit = "/-/commit/{commit}",
          },
        },
      },
    },
  },
}
