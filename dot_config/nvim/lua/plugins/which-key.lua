vim.pack.add({
  "https://github.com/folke/which-key.nvim",
})

require("which-key").setup({
  preset = "helix",
  spec = {
    {
      mode = { "n", "v" },
      { "<leader><tab>", group = "tabs" },
      { "<leader>p", group = "plugins", mode = "n" },
      { "<leader>c", group = "code" },
      { "<leader>d", group = "debug" },
      { "<leader>dp", group = "profiler" },
      { "<leader>f", group = "file/find" },
      { "<leader>g", group = "git" },
      { "<leader>q", group = "quit/session" },
      { "<leader>s", group = "search", mode = "n" },
      { "<leader>u", group = "ui", icon = { icon = "󰙵 ", color = "cyan" } },
      { "<leader>x", group = "diagnostics/quickfix", icon = { icon = "󱖫 ", color = "green" } },
      { "[", group = "prev" },
      { "]", group = "next" },
      { "g", group = "goto" },
      { "gs", group = "surround" },
      { "z", group = "fold" },
      {
        "<leader>b",
        group = "buffer",
        expand = function() return require("which-key.extras").expand.buf() end,
      },
      {
        "<leader>w",
        group = "windows",
        proxy = "<c-w>",
        expand = function() return require("which-key.extras").expand.win() end,
      },
      { "gx", desc = "Open with system app" },
    },
  },
})

vim.keymap.set("n", "<leader>?", function()
  require("which-key").show({ global = false })
end, { desc = "Buffer Keymaps (which-key)" })

vim.keymap.set("n", "<c-w><space>", function()
  require("which-key").show({ keys = "<c-w>", loop = true })
end, { desc = "Window Hydra Mode (which-key)" })
