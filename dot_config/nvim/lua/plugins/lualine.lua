local ignored_filetypes = {
  "Trouble",
  "alpha",
  "dashboard",
  "fzf",
  "help",
  "lazy",
  "leetcode.nvim",
  "mason",
  "neo-tree",
  "notify",
  "snacks_dashboard",
  "snacks_notif",

  -- "snacks_terminal",
  "snacks_win",
  "toggleterm",
  "trouble",
  "qf",

  -- dap / dapui stuff
  "dap-repl",
  "dapui_breakpoints",
  "dapui_console",
  "dapui_scopes",
  "dapui_stacks",
  "dapui_watches",
  "dap-view",
  "dap-view-term",
}

vim.pack.add({
  "https://github.com/nvim-lualine/lualine.nvim",
  "https://github.com/bwpge/lualine-pretty-path",
})

require("lualine").setup({
  options = {
    section_separators = { left = "", right = "" },
    component_separators = { left = "", right = "" },
    disabled_filetypes = {
      statusline = ignored_filetypes,
      winbar = ignored_filetypes,
    },
    globalstatus = true,
    theme = "rose-pine",
  },
  sections = {
    lualine_a = { { "mode", fmt = function(res) return res:sub(1, 1) end } },
    lualine_b = { { "branch" }, { function() return "|" end, padding = 0 }, { "pretty_path" } },
    lualine_c = { { "diagnostics" }, { "lsp_status" } },
    lualine_x = { { "filetype" }, { "encoding" } },
    lualine_y = { { "location" } },
    lualine_z = { { "progress" } },
  },
  winbar = {},
})
