-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = vim.keymap.set

map({ "v", "n" }, "<Up>", "<Nop>", { desc = "remove arrow-up bind" })
map({ "v", "n" }, "<Down>", "<Nop>", { desc = "remove arrow-down bind" })
map({ "v", "n" }, "<Right>", "<Nop>", { desc = "remove arrow-right bind" })
map({ "v", "n" }, "<Left>", "<Nop>", { desc = "remove arrow-up bind" })

map({ "n", "x" }, "&", "<Cmd>&&<CR>", { desc = "Repeat last :substitute with flags" })
