-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank({
      higroup = "IncSearch", -- The highlight group to use, customize as desired
      timeout = 1000, -- Duration of highlight in milliseconds
    })
  end,
})
