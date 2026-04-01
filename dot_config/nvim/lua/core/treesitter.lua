return {
  {
    "folke/which-key.nvim",
    opts = {
      spec = {
        { "<BS>", desc = "Decrement Selection", mode = "x" },
        { "<C-space>", desc = "Increment Selection", mode = { "x", "n" } },
      },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    lazy = false,
    build = ":TSUpdate",

    keys = {
      { "<C-space>", desc = "Increment Selection", mode = { "n", "x" } },
      { "<BS>", desc = "Decrement Selection", mode = "x" },
    },

    init = function()
      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "*" },
        callback = function() vim.treesitter.start() end,
      })
    end,

    config = function(_, opts) require("nvim-treesitter").setup(opts) end,

    opts = {
      ensure_installed = { "lua", "luadoc", "vim", "vimdoc" },
      auto_install = true,
      highlight = { enable = true },
      indent = { enable = true },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<C-space>",
          node_incremental = "<C-space>",
          node_decremental = "<BS>",
          scope_incremental = false,
        },
      },
      textobjects = {
        move = {
          enable = true,
          goto_next_start = {
            ["]f"] = "@function.outer",
            ["]c"] = "@class.outer",
            ["]a"] = "@parameter.inner",
          },
          goto_next_end = {
            ["]F"] = "@function.outer",
            ["]C"] = "@class.outer",
            ["]A"] = "@parameter.inner",
          },
          goto_previous_start = {
            ["[f"] = "@function.outer",
            ["[c"] = "@class.outer",
            ["[a"] = "@parameter.inner",
          },
          goto_previous_end = {
            ["[F"] = "@function.outer",
            ["[C"] = "@class.outer",
            ["[A"] = "@parameter.inner",
          },
        },

        swap = {
          enable = true,
          swap_next = { ["<M-l>"] = "@parameter.inner" },
          swap_previous = { ["<M-h>"] = "@parameter.inner" },
        },
      },
    },
  },
  { "nvim-treesitter/nvim-treesitter-textobjects", branch = "main" },
  {
    "nvim-treesitter/nvim-treesitter-context",
    opts = function()
      vim.api.nvim_set_hl(0, "TreesitterContext", { link = "@comment" })
      return {
        mode = "cursor",
        max_lines = 3,
      }
    end,
  },
}
