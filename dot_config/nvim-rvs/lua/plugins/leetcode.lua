local leet_arg = "lc"

return {
  {
    "folke/which-key.nvim",
    opts = { spec = { { "<leader>;", group = "LeetCode" } } },
  },
  {
    "kawre/leetcode.nvim",
    build = ":TSUpdate html",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      "nvim-tree/nvim-web-devicons",
      "3rd/image.nvim",
    },
    cmd = "Leet",
    lazy = leet_arg ~= vim.fn.argv()[1],
    keys = {
      { "<leader>;L", "<cmd>Leet lang<CR>", desc = "Change Language" },
      { "<leader>;d", "<cmd>Leet daily<CR>", desc = "Daily Question" },
      { "<leader>;i", "<cmd>Leet info<CR>", desc = "Question Info" },
      { "<leader>;l", "<cmd>Leet list<CR>", desc = "List of Question" },
      { "<leader>;m", "<cmd>Leet menu<CR>", desc = "Leetcode Menu" },
      { "<leader>;r", "<cmd>Leet restore<CR>", desc = "Restore (preview) layout" },
      { "<leader>;s", "<cmd>Leet submit<CR>", desc = "Submit" },
      { "<leader>;t", "<cmd>Leet test<CR>", desc = "Test" },
      { "<leader>;h", "<cmd>Leet hints<CR>", desc = "Hints" },
    },
    --- @module 'leetcode'
    opts = {
      arg = leet_arg,
      lang = "golang",
      plugins = {
        non_standalone = false,
      },

      image_support = false, ---@type boolean

      ---@type lc.picker
      picker = { provider = "snacks-picker" },

      console = {
        open_on_runcode = true, ---@type boolean
        dir = "row", --- @type lc.direction
        size = { ---@type lc.size
          width = "70%",
          height = "70%",
        },
        result = {
          size = "50%", ---@type lc.size
        },

        testcase = {
          virt_text = true, ---@type boolean
          size = "50%", ---@type lc.size
        },
      },

      description = {
        position = "left", ---@type lc.position
        width = "50%", ---@type lc.size
        show_stats = true, ---@type boolean
      },

      keys = {
        toggle = { "q", "<Esc>" }, ---@type string|string[]
        confirm = { "<CR>" }, ---@type string|string[]

        reset_testcases = "r", ---@type string
        use_testcase = "U", ---@type string
        focus_testcases = "H", ---@type string
        focus_result = "L", ---@type string
      },
    },
  },
}
