--- --- @type vim.diagnostic.Opts
--- local config = {
---   signs = {
---     text = {
---       [vim.diagnostic.severity.ERROR] = "",
---       [vim.diagnostic.severity.WARN] = "",
---       [vim.diagnostic.severity.HINT] = "",
---       [vim.diagnostic.severity.INFO] = "",
---     },
---   },
---   update_in_insert = true,
---   underline = true,
---   severity_sort = true,
---   float = {
---     focusable = false,
---     style = "minimal",
---     border = "single",
---     source = "always",
---     header = "",
---     prefix = "",
---     suffix = "",
---   },
--- }
--- vim.diagnostic.config(config)
---
--- local icons = {
---   Class = " ",
---   Color = " ",
---   Constant = " ",
---   Constructor = " ",
---   Enum = " ",
---   EnumMember = " ",
---   Event = " ",
---   Field = " ",
---   File = " ",
---   Folder = " ",
---   Function = "󰊕 ",
---   Interface = " ",
---   Keyword = " ",
---   Method = "ƒ ",
---   Module = "󰏗 ",
---   Property = " ",
---   Snippet = " ",
---   Struct = " ",
---   Text = " ",
---   Unit = " ",
---   Value = " ",
---   Variable = " ",
--- }
---
--- local completion_kinds = vim.lsp.protocol.CompletionItemKind
--- for i, kind in ipairs(completion_kinds) do
---   completion_kinds[i] = icons[kind] and icons[kind] .. kind or kind
--- end

return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      -- FIXME:
      -- "folke/snacks.nvim",
    },
    keys = {
      -- {
      --   "<leader>cl",
      --   function()
      --     require("snacks").picker.lsp_config()
      --   end,
      --   desc = "Lsp Info",
      -- },
      { "gd", vim.lsp.buf.definition, desc = "Goto Definition" },
      { "gr", vim.lsp.buf.references, desc = "References", nowait = true },
      { "gi", vim.lsp.buf.implementation, desc = "Goto Implementation" },
      { "gy", vim.lsp.buf.type_definition, desc = "Goto T[y]pe Definition" },
      { "gD", vim.lsp.buf.declaration, desc = "Goto Declaration" },
      { "K", vim.lsp.buf.hover, desc = "Hover" },
      { "gK", vim.lsp.buf.signature_help, desc = "Signature Help" },
      { "<c-k>", vim.lsp.buf.signature_help, mode = "i", desc = "Signature Help" },
      { "<leader>ca", vim.lsp.buf.code_action, desc = "Code Action", mode = { "n", "v" } },
      { "<leader>cc", vim.lsp.codelens.run, desc = "Run Codelens", mode = { "n", "v" } },
      { "<leader>cC", vim.lsp.codelens.refresh, desc = "Refresh & Display Codelens", mode = { "n" } },
      { "<leader>cr", vim.lsp.buf.rename, desc = "Rename" },
    },
    init = function()
      -- Remove default keybinds
      for _, bind in ipairs({ "grn", "gra", "gri", "grr" }) do
        vim.keymap.del("n", bind)
      end
    end,
    config = function() end,
  },
  {
    "mason-org/mason.nvim",
    keys = { { "<leader>cm", "<cmd>Mason<cr>", desc = "Mason" } },
    opts = {},
  },
  {
    "mason-org/mason-lspconfig.nvim",
    dependencies = {
      { "mason-org/mason.nvim", opts = {} },
      "neovim/nvim-lspconfig",
    },
    opts = {
      automatic_enable = true,
      ensure_installed = { "lua_ls", "gopls" },
    },
  },
}
