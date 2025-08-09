return {
  {
    "echasnovski/mini.pairs",
    event = "VeryLazy",
    opts = {
      modes = { insert = true, command = true, terminal = false },
      -- skip autopair when next character is one of these
      skip_next = [=[[%w%%%'%[%"%.%`%$]]=],
      -- skip autopair when the cursor is inside these treesitter nodes
      skip_ts = { "string" },
      -- skip autopair when next character is closing pair
      -- and there are more closing pairs than opening pairs
      skip_unbalanced = true,
      -- better deal with markdown code blocks
      markdown = true,
    },
  },
  {
    "echasnovski/mini.indentscope",
    version = false, -- wait till new 0.7.0 release to put it back on semver
    opts = {
      -- symbol = "▏",
      symbol = "│",
      options = { try_as_border = true },
    },
    -- init = function()
    --   vim.api.nvim_create_autocmd("FileType", {
    --     pattern = {
    --       "Trouble",
    --       "alpha",
    --       "dashboard",
    --       "fzf",
    --       "help",
    --       "lazy",
    --       "mason",
    --       "neo-tree",
    --       "notify",
    --       "snacks_dashboard",
    --       "snacks_notif",
    --       "snacks_terminal",
    --       "snacks_win",
    --       "toggleterm",
    --       "trouble",
    --     },
    --     callback = function()
    --       vim.b.miniindentscope_disable = true
    --     end,
    --   })
    --
    --   vim.api.nvim_create_autocmd("User", {
    --     pattern = "SnacksDashboardOpened",
    --     callback = function(data)
    --       vim.b[data.buf].miniindentscope_disable = true
    --     end,
    --   })
    -- end,
  },
  {
    "echasnovski/mini.ai",
    event = "VeryLazy",
    opts = function()
      local ai = require("mini.ai")
      return {
        n_lines = 500,
        custom_textobjects = {
          o = ai.gen_spec.treesitter({ -- code block
            a = { "@block.outer", "@conditional.outer", "@loop.outer" },
            i = { "@block.inner", "@conditional.inner", "@loop.inner" },
          }),
          f = ai.gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }), -- function
          c = ai.gen_spec.treesitter({ a = "@class.outer", i = "@class.inner" }), -- class
          t = { "<([%p%w]-)%f[^<%w][^<>]->.-</%1>", "^<.->().*()</[^/]->$" }, -- tags
          d = { "%f[%d]%d+" }, -- digits
          e = { -- Word with case
            { "%u[%l%d]+%f[^%l%d]", "%f[%S][%l%d]+%f[^%l%d]", "%f[%P][%l%d]+%f[^%l%d]", "^[%l%d]+%f[^%l%d]" },
            "^().*()$",
          },
          u = ai.gen_spec.function_call(), -- u for "Usage"
          U = ai.gen_spec.function_call({ name_pattern = "[%w_]" }), -- without dot in function name
        },
      }
    end,
  },
  { "echasnovski/mini.align", version = "*", opts = {} },
}
