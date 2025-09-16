return {
  "smjonas/inc-rename.nvim",
  opts = { preview_empty_name = true },
  keys = {
    {
      "<leader>cr",
      function()
        local inc_rename = require("inc_rename")
        return ":" .. inc_rename.config.cmd_name .. " " .. vim.fn.expand("<cword>")
      end,
      expr = true,
      desc = "Rename (inc-rename.nvim)",
      remap = false,
    },
  },
}
