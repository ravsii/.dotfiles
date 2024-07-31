return {
  { "folke/todo-comments.nvim", keys = {} },
  {
    "klen/nvim-config-local",
    opts = {
      -- Config file patterns to load (lua supported)
      config_files = { ".nvim.lua", ".nvimrc", ".exrc" },

      -- Where the plugin keeps files data
      hashfile = vim.fn.stdpath("data") .. "/config-local",

      autocommands_create = true, -- Create autocommands (VimEnter, DirectoryChanged)
      commands_create = true, -- Create commands (ConfigLocalSource, ConfigLocalEdit, ConfigLocalTrust, ConfigLocalIgnore)
      silent = false, -- Disable plugin messages (Config loaded/ignored)
      lookup_parents = true, -- Lookup config files in parent directories
    },
  },
  {
    "folke/which-key.nvim",
    opts = function(_, opts)
      opts.icons = {
        rules = false,
      }
    end,
  },
  {
    "smjonas/inc-rename.nvim",
    cmd = "IncRename",
    opts = {
      preview_empty_name = true,
    },
  },
  -- {
  --   "telescope.nvim",
  --   keys = {
  --     {
  --       "<leader>sn",
  --       function()
  --         -- require("telescope").load_extension("notify")
  --         require("telescope").extensions.notify.notify()
  --       end,
  --       desc = "Goto Notify List",
  --     },
  --     { "<leader><space>", LazyVim.pick("auto"), desc = "Find Files" },
  --   },
  -- },
  {
    "tummetott/unimpaired.nvim",
    -- I randomly found this behaviour in Helix, and it's really life-changing
    opts = {
      keymaps = {
        blank_above = {
          mapping = "[<Space>",
          description = "Add [count] blank lines above",
          dot_repeat = true,
        },
        blank_below = {
          mapping = "]<Space>",
          description = "Add [count] blank lines below",
          dot_repeat = true,
        },
      },
    },
  },
  {
    "L3MON4D3/LuaSnip",
    keys = function()
      return {}
    end,
  }, -- luasnip breaks tab
  {
    "chrisgrieser/nvim-spider",
    keys = {
      {
        "w",
        "<cmd>lua require('spider').motion('w')<CR>",
        mode = { "n", "o", "x" },
        desc = "Move to end of word",
      },
      {
        "e",
        "<cmd>lua require('spider').motion('e')<CR>",
        mode = { "n", "o", "x" },
        desc = "Move to start of next word",
      },
      {
        "b",
        "<cmd>lua require('spider').motion('b')<CR>",
        mode = { "n", "o", "x" },
        desc = "Move to start of previous word",
      },
    },
  },
}
