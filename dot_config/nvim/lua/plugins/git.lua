return {
  {
    "akinsho/git-conflict.nvim",
    version = "*",
    event = { "BufWinEnter", "BufNewFile" },
    keys = {
      { "<leader>Cc", "<cmd>GitConflictChooseOurs<cr>", mode = "n", desc = "Accept current" },
      { "<leader>Ci", "<cmd>GitConflictChooseTheirs<cr>", mode = "n", desc = "Accept incoming" },
      { "<leader>Cb", "<cmd>GitConflictChooseBoth<cr>", mode = "n", desc = "Choose both changes" },
      { "<leader>Cn", "<cmd>GitConflictChooseNone<cr>", mode = "n", desc = "Choose none of the changes" },
      { "<leader>Cq", "<cmd>GitConflictListQf<cr>", mode = "n", desc = "List conflicts in quickfix" },
      { "[x", "<cmd>GitConflictPrevConflict<cr>", mode = "n", desc = "Previous conflict" },
      { "]x", "<cmd>GitConflictNextConflict<cr>", mode = "n", desc = "Next conflict" },
    },
    ---@module "git-conflict"
    ---@type GitConflictConfig
    opts = {
      ---@diagnostic disable-next-line
      default_mappings = false, -- disable buffer local mapping created by this plugin
      default_commands = true,
      disable_diagnostics = true,
      list_opener = "copen",
      highlights = {
        incoming = "DiffAdd",
        ancestor = "DiffChange",
        current = "DiffText",
      },
      debug = false,
    },
    init = function()
      require("which-key").add({
        { "<leader>C", group = "git conflicts", icon = { icon = " " } },
      })
    end,
  },
}
