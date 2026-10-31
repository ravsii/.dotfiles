vim.pack.add({
  "https://github.com/FylerOrg/fyler.nvim",
})

require("fyler").setup({
  auto_confirm_simple_mutation = false,
  integrations = { icon = "nvim_web_devicons" },
  hooks = {
    on_highlight = function(highlights)
      local color = require("rose-pine.palette").love
      highlights.FylerFloatBorder.fg = color
      highlights.FylerFloatTitle.fg = color
    end,
    on_rename = function(src_path, destination_path) Snacks.rename.on_rename_file(src_path, destination_path) end,
  },
  extensions = {
    git = { enabled = true },
  },
  kind = "floating",
  kind_presets = {
    floating = {
      width = 80,
      border = "rounded",
      title = " Fyler ",
      title_pos = "center",
      win_opts = { winhighlight = "FloatBorder:FylerFloatBorder,FloatTitle:FylerFloatTitle" },
    },
    split_left_most = {
      width = 40,
      win_opts = { winbar = "%{substitute(bufname('%'), '^fyler-[^:]*://', '', '')}" },
    },
  },
  use_as_default_explorer = true,
  ui = {
    indent_guides = true,
  },
})

vim.keymap.set(
  "n",
  "<leader>E",
  function() require("fyler").toggle({ kind = "split_left_most" }) end,
  { desc = "Toggle file explorer" }
)
vim.keymap.set(
  "n",
  "<leader>e",
  function() require("fyler").toggle({ kind = "floating" }) end,
  { desc = "Toggle file explorer" }
)
