local leet_arg = "lc"

return {
  {
    "kawre/leetcode.nvim",
    build = ":TSUpdate html",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      "nvim-tree/nvim-web-devicons",
      -- "3rd/image.nvim",
      "folke/snacks.nvim",
    },
    cmd = "Leet",
    lazy = leet_arg ~= vim.fn.argv()[1],
    opts = function()
      ---@diagnostic disable-next-line: inject-field
      Snacks.config.picker.enabled = true

      -- Add keys only on actual load
      require("which-key").add({
        { "<leader>;", group = "leetcode", icon = { icon = " " } },
        { "<leader>;l", "<cmd>Leet lang<CR>", desc = "change [l]anguage" },
        { "<leader>;d", "<cmd>Leet daily<CR>", desc = "[d]aily problem" },
        { "<leader>;i", "<cmd>Leet info<CR>", desc = "question [i]nfo" },
        { "<leader>;p", "<cmd>Leet list<CR>", desc = "[p]problems" },
        { "<leader>;m", "<cmd>Leet menu<CR>", desc = "[m]enu" },
        { "<leader>;r", "<cmd>Leet restore<CR>", desc = "[r]estore layout" },
        { "<leader>;s", "<cmd>Leet submit<CR>", desc = "[s]ubmit" },
        { "<leader>;t", "<cmd>Leet test<CR>", desc = "[t]est" },
        { "<leader>;h", "<cmd>Leet hints<CR>", desc = "[h]ints" },
      })

      -- Enable wrap for question window
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "leetcode.nvim",
        callback = function() vim.opt_local.wrap = true end,
      })

      --- @module 'leetcode'
      return {
        arg = leet_arg,
        lang = "golang",
        plugins = {
          non_standalone = false,
        },

        ---@type lc.storage
        storage = { home = vim.fn.expand("~/.leetcode-nvim") },

        image_support = false, ---@type boolean

        editor = {
          reset_previous_code = false, ---@type boolean
          fold_imports = true, ---@type boolean
        },

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

        injector = { ---@type table<lc.lang, lc.inject>
          ["golang"] = { before = "package leetcode" },
        },
      }
    end,
  },
}
