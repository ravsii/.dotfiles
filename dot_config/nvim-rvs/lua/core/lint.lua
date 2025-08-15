return {
  {
    "mfussenegger/nvim-lint",
    event = { "BufReadPost", "BufWritePost", "BufNewFile" },
    config = function()
      local lint = require("lint")
      lint.linters_by_ft = require("install").linters_by_ft

      local callback = function()
        lint.try_lint()
      end

      -- Auto run linters
      vim.api.nvim_create_autocmd(
        { "BufWritePost", "BufWinEnter", "InsertLeave" },
        { callback = callback }
      )
    end,
  },
}
