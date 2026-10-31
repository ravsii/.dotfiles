vim.opt_local.colorcolumn = "81"
vim.opt_local.tabstop = 2
vim.opt_local.shiftwidth = 2
vim.opt_local.wrap = true

-- Wrap относится к окну: выставляем его для входящего буфера, чтобы не наследовали другие файлы.
vim.api.nvim_create_autocmd("BufWinEnter", {
  group = vim.api.nvim_create_augroup("MarkdownWrap", { clear = true }),
  callback = function()
    vim.opt_local.wrap = vim.bo.filetype == "markdown"
  end,
})
