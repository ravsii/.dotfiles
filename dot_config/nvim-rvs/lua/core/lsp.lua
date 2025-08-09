local lspHover = function()
  vim.lsp.buf.hover({
    max_width = 80,
    max_height = 24,
    anchor_bias = "below",
    wrap = true,
  })
end

return {
  {
    "neovim/nvim-lspconfig",
    dependencies = { "folke/snacks.nvim" },
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
      { "K", lspHover, desc = "Hover" },
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
    config = function()
      local icons = require("icons")

      --- @type vim.diagnostic.Opts
      local config = {
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = icons.diagIcons.Error,
            [vim.diagnostic.severity.WARN] = icons.diagIcons.Warning,
            [vim.diagnostic.severity.HINT] = icons.diagIcons.Hint,
            [vim.diagnostic.severity.INFO] = icons.diagIcons.Info,
          },
        },
        update_in_insert = true,
        underline = true,
        severity_sort = true,
        -- Enable this to enable the builtin LSP inlay hints on Neovim >= 0.10.0
        -- Be aware that you also will need to properly configure your LSP server to
        -- provide the inlay hints.
        inlay_hints = {
          enabled = true,
        },
        virtual_lines = {
          current_line = true,
        },
        virtual_text = {
          spacing = 2,
          source = "if_many",
          prefix = "",
          virt_text_pos = "eol",
        },
      }

      local completion_kinds = vim.lsp.protocol.CompletionItemKind
      for i, kind in ipairs(completion_kinds) do
        completion_kinds[i] = icons.lspIcons[kind] and icons.lspIcons[kind] .. kind or kind
      end

      vim.diagnostic.config(config)
    end,
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
      ensure_installed = { "lua_ls" },
    },
  },
}
