-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here
-- make it easier to close man-files when opened inline
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "*" },
  callback = function(args)
    local ft = vim.bo[args.buf].filetype

    if ft == "typescript" or ft == "javascript" or ft == "svelte" then
      vim.opt.shiftwidth = 2
      vim.opt.tabstop = 2
    end
    if ft == "python" or ft == "python3" then
      vim.opt.colorcolumn = "88"
    end
  end,
})
