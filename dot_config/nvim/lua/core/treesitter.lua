local ts_parsers = require("install").treesitter

---@param bind string
---@param group string
---@return table folkeKeymap
local function goto_next(bind, group)
  return {
    bind,
    function() require("nvim-treesitter-textobjects.move").goto_next_start(group) end,
    desc = "Next " .. group,
    mode = { "n", "x", "o" },
  }
end

---@param bind string
---@param group string
---@return table folkeKeymap
local function goto_prev(bind, group)
  return {
    bind,
    function() require("nvim-treesitter-textobjects.move").goto_previous_start(group) end,
    desc = "Next " .. group,
    mode = { "n", "x", "o" },
  }
end

return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    lazy = false,
    build = ":TSUpdate",
    keys = {
      {
        "[n",
        function() require("vim.treesitter._select").select_prev(vim.v.count1) end,
        mode = "x",
        desc = "Select previous treesitter node",
      },
      {
        "]n",
        function() require("vim.treesitter._select").select_next(vim.v.count1) end,
        mode = "x",
        desc = "Select next treesitter node",
      },
      {
        "<C-Space>",
        function()
          if vim.treesitter.get_parser(nil, nil, { error = false }) then
            require("vim.treesitter._select").select_parent(vim.v.count1)
          else
            vim.lsp.buf.selection_range(vim.v.count1)
          end
        end,
        mode = { "n", "x", "o" },
        desc = "Select parent treesitter node or outer incremental lsp selections",
      },
      {
        "<BS>",
        function()
          if vim.treesitter.get_parser(nil, nil, { error = false }) then
            require("vim.treesitter._select").select_child(vim.v.count1)
          else
            vim.lsp.buf.selection_range(-vim.v.count1)
          end
        end,
        mode = { "n", "x", "o" },
        desc = "Select child treesitter node or inner incremental lsp selections",
      },
    },
    config = function()
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "*",
        callback = function(args) pcall(vim.treesitter.start, args.buf) end,
      })

      local ts = require("nvim-treesitter")

      ts.setup()
      local default_grammars = { "lua", "luadoc", "vim", "vimdoc" }
      ts.install(vim.tbl_extend("force", default_grammars, ts_parsers))
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    branch = "main",
    lazy = false,
    keys = {
      -- Swap
      {
        "<M-h>",
        function() require("nvim-treesitter-textobjects.swap").swap_previous("@parameter.inner") end,
        desc = "Swap previous parameter",
        mode = { "n" },
      },
      {
        "<M-l>",
        function() require("nvim-treesitter-textobjects.swap").swap_next("@parameter.inner") end,
        desc = "Swap next parameter",
        mode = { "n", "x", "o" },
      },
      -- Go To Next / Prev
      goto_next("]f", "@function.outer"),
      goto_prev("[f", "@function.outer"),
      goto_next("]a", "@parameter.outer"),
      goto_prev("[a", "@parameter.outer"),
      goto_next("]c", "@class.outer"),
      goto_prev("[c", "@class.outer"),
    },
    opts = {
      move = { set_jumps = true },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter-context",
    config = function()
      require("treesitter-context").setup({
        enable = true,
        multiwindow = true, -- Enable multiwindow support.
        max_lines = 3,
        line_numbers = true,
        multiline_threshold = 20,
        trim_scope = "outer",
        mode = "topline",
      })
    end,
  },
}
