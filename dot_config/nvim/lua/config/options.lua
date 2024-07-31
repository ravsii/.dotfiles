-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

local opt = vim.opt

opt.mouse = "n"
opt.shiftwidth = 4
opt.tabstop = 4
opt.spelllang = { "en", "ru" }
opt.scrolloff = 20
opt.colorcolumn = "80,120"
opt.tw = 79

local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
  opts = opts or {}
  opts.border = opts.border or "single"
  opts.max_width = opts.max_width or 80
  return orig_util_open_floating_preview(contents, syntax, opts, ...)
end

vim.g.lazyvim_picker = "fzf"
