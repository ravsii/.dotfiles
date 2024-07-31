local leet_arg = "leetcode.nvim"

return {
  {
    "folke/which-key.nvim",
    opts = function(_, opts)
      table.insert(opts.spec, { "<leader>;", group = "leetcode" })
    end,
  },
  {
    "vhyrro/luarocks.nvim",
    priority = 1001, -- this plugin needs to run before anything else
    opts = {
      rocks = { "magick" },
    },
  },
  {
    "3rd/image.nvim",
    dependencies = { "luarocks.nvim" },
    opts = {
      backend = "kitty",
      integrations = {
        markdown = {
          enabled = true,
          clear_in_insert_mode = false,
          download_remote_images = true,
          only_render_image_at_cursor = false,
          filetypes = { "markdown", "vimwiki" }, -- markdown extensions (ie. quarto) can go here
        },
        neorg = {
          enabled = true,
          clear_in_insert_mode = false,
          download_remote_images = true,
          only_render_image_at_cursor = false,
          filetypes = { "norg" },
        },
        html = {
          enabled = false,
        },
        css = {
          enabled = false,
        },
      },
      max_width = nil,
      max_height = nil,
      max_width_window_percentage = nil,
      max_height_window_percentage = 50,
      window_overlap_clear_enabled = false, -- toggles images when windows are overlapped
      window_overlap_clear_ft_ignore = { "cmp_menu", "cmp_docs", "" },
      editor_only_render_when_focused = false, -- auto show/hide images when the editor gains/looses focus
      tmux_show_only_in_active_window = false, -- auto show/hide images in the correct Tmux window (needs visual-activity off)
      hijack_file_patterns = { "*.png", "*.jpg", "*.jpeg", "*.gif", "*.webp", "*.avif" }, -- render image files as images when opened
    },
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
    opts = {
      arg = leet_arg,
      lang = "golang",
      plugins = {
        non_standalone = false,
      },

      ---@type boolean
      image_support = true,

      console = {
        open_on_runcode = true, ---@type boolean

        dir = "row", ---@type lc.direction

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
