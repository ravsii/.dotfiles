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
opt.relativenumber = true
opt.fixeol = false
opt.conceallevel = 0
opt.messagesopt = "wait:2000,history:500"

-- disable netrw
vim.g.loaded_netrwPlugin = 1
vim.g.loaded_netrw = 1

-- LazyVim specific
vim.g.lazyvim_picker = "snacks"
vim.g.lazyvim_python_lsp = "pyright"

-- :Inspect fix https://github.com/neovim/neovim/issues/31675
vim.hl = vim.highlight
