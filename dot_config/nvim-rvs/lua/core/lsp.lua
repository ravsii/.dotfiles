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

    -- stylua: ignore
    keys = {
      { "K",          lspHover,                                             desc = "Hover" },
      { "gd",         function() Snacks.picker.lsp_definitions() end,       desc = "Goto Definition",            noremap = true},
      { "gD",         vim.lsp.buf.declaration,                              desc = "Goto Declaration" },
      { "gI",         function() Snacks.picker.lsp_implementations() end,   desc = "Goto Implementation" },
      { "gK",         vim.lsp.buf.signature_help,                           desc = "Signature Help" },
      { "gr",         function() Snacks.picker.lsp_references() end,        desc = "References",                 noremap=true, nowait = true },
      { "gy",         function() Snacks.picker.lsp_type_definitions() end,  desc = "Goto T[y]pe Definition" },
      { "<c-k>",      vim.lsp.buf.signature_help,                           desc = "Signature Help",             mode = "i" },
      { "<leader>cC", vim.lsp.codelens.refresh,                             desc = "Refresh & Display Codelens", mode = { "n" } },
      { "<leader>ca", vim.lsp.buf.code_action,                              desc = "Code Action",                mode = { "n", "v" } },
      { "<leader>cc", vim.lsp.codelens.run,                                 desc = "Run Codelens",               mode = { "n", "v" } },
      { "<leader>cl", function() Snacks.picker.lsp_config() end,            desc = "Lsp Info" },
      { "<leader>cr", vim.lsp.buf.rename,                                   desc = "Rename" },
      { "<leader>ss", function() Snacks.picker.lsp_symbols() end,           desc = "LSP Symbols" },
      { "<leader>sS", function() Snacks.picker.lsp_workspace_symbols() end, desc = "LSP Workspace Symbols" },
      -- { "<leader>ss", function() Snacks.picker.lsp_symbols() end,          desc = "LSP Symbols" },
      -- { "<leader>sS", function() Snacks.picker.lsp_workspace_symbols({ filter = LazyVim.config.kind_filter }) end, desc = "LSP Workspace Symbols", has = "workspace/symbols" },
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
        -- virtual_lines = {
        --   current_line = true,
        -- },
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
    opts = function()
      local i = require("install")
      return {
        automatic_enable = { exclude = i.lsp_enable_exclude },
      }
    end,
  },
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    opts = function()
      local i = require("install")
      i:add_mason({ "lua_ls" })
      return {
        ensure_installed = i.lsp,
        auto_update = false,
        run_on_start = true,
      }
    end,
  },
}
