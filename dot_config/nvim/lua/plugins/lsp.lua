vim.pack.add({
  "https://github.com/mason-org/mason.nvim",
  "https://github.com/neovim/nvim-lspconfig",
  "https://github.com/mason-org/mason-lspconfig.nvim",
  "https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim",
  "https://github.com/folke/lazydev.nvim",
  "https://github.com/b0o/SchemaStore.nvim",
  "https://github.com/rachartier/tiny-inline-diagnostic.nvim",
  "https://github.com/smjonas/inc-rename.nvim",
})

vim.diagnostic.config({
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = "",
      [vim.diagnostic.severity.WARN] = "",
      [vim.diagnostic.severity.INFO] = "",
      [vim.diagnostic.severity.HINT] = "",
    },
  },
  virtual_text = false,
  virtual_lines = false,
  update_in_insert = true,
  underline = true,
  severity_sort = true,
  float = {
    max_width = 80,
    anchor_bias = "below",
    wrap = true,
    focusable = true,
  },
})

require("tiny-inline-diagnostic").setup({
  preset = "modern",
  transparent_bg = false,
  transparent_cursorline = true,
  hi = {
    mixing_color = require("rose-pine.palette").surface,
  },
  options = {
    show_source = {
      enabled = true,
      if_many = false,
    },
    softwrap = 30,
    use_icons_from_diagnostic = false,
    set_arrow_to_diag_color = false,
    add_messages = true,
    multilines = {
      enabled = true,
      always_show = false,
      trim_whitespaces = true,
    },
    overflow = {
      mode = "wrap",
      padding = 2,
    },
    show_all_diags_on_cursorline = false,
  },
})

-- Lua
require("lazydev").setup({
  library = {
    { path = "${3rd}/luv/library", words = { "vim%.uv" } },
    { path = "snacks.nvim", words = { "Snacks" } },
  },
})

require("inc_rename").setup({ preview_empty_name = true })

-- Go
vim.lsp.config("gopls", {
  settings = {
    gopls = {
      analyses = { composites = false, fieldalignment = false },
    },
  },
})

-- Lua
vim.lsp.config("lua_ls", {
  settings = {
    Lua = {
      runtime = { version = "LuaJIT" },
      diagnostics = { globals = { "vim", "require" } },
      workspace = { library = vim.api.nvim_get_runtime_file("", true) },
      telemetry = { enable = false },
    },
  },
})

-- JSON
vim.lsp.config("jsonls", {
  settings = {
    json = {
      schemas = require("schemastore").json.schemas(),
      validate = { enable = true },
    },
  },
})

-- YAML
vim.lsp.config("yamlls", {
  settings = {
    yaml = {
      schemaStore = { enable = false, url = "" },
      schemas = require("schemastore").yaml.schemas(),
    },
  },
})

-- Mason
require("ozon")
require("mason").setup()
require("mason-lspconfig").setup()
require("mason-tool-installer").setup({
  ensure_installed = {
    -- Go
    "gopls",
    "golangci_lint_ls",
    "golangci-lint",
    "goimports",
    "gci",
    "gofumpt",
    -- Go DAP
    "delve",
    -- Lua
    "lua_ls",
    "stylua",
    -- Shell
    "shfmt",
    -- JSON
    "jsonls",
    -- YAML
    "yamlls",
    -- Markdown
    "marksman",
    "markdown-toc",
    -- Proto
    "buf_ls",
  },
  auto_update = true,
  run_on_start = true,
})

vim.keymap.set("n", "<leader>cm", "<cmd>Mason<cr>", { desc = "Mason" })

vim.keymap.set(
  "n",
  "K",
  function()
    vim.lsp.buf.hover({
      close_events = { "CursorMoved", "BufHidden", "LspDetach" },
      max_width = 80,
      anchor_bias = "below",
      wrap = true,
      focusable = true,
    })
  end,
  { desc = "Hover" }
)
vim.keymap.set("n", "gd", function() Snacks.picker.lsp_definitions() end, { desc = "Goto Definition" })
vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { desc = "Goto Declaration" })
vim.keymap.set("n", "gI", function() Snacks.picker.lsp_implementations() end, { desc = "Goto Implementation" })
vim.keymap.set("n", "gK", vim.lsp.buf.signature_help, { desc = "Signature Help" })
vim.keymap.set("n", "gr", function() Snacks.picker.lsp_references() end, { desc = "References", nowait = true })
vim.keymap.set("n", "gy", function() Snacks.picker.lsp_type_definitions() end, { desc = "Goto T[y]pe Definition" })
vim.keymap.set("i", "<C-k>", vim.lsp.buf.signature_help, { desc = "Signature Help" })

vim.keymap.set("n", "<leader>cC", vim.lsp.codelens.refresh, { desc = "Refresh & Display Codelens" })
vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { desc = "Code Action" })
vim.keymap.set({ "n", "v" }, "<leader>cc", vim.lsp.codelens.run, { desc = "Run Codelens" })
vim.keymap.set("n", "<leader>cl", function() Snacks.picker.lsp_config() end, { desc = "Lsp Info" })
vim.keymap.set(
  "n",
  "<leader>cr",
  function() return ":" .. require("inc_rename").config.cmd_name .. " " .. vim.fn.expand("<cword>") end,
  { expr = true, desc = "Rename (inc-rename.nvim)" }
)
vim.keymap.set("n", "<leader>ss", function() Snacks.picker.lsp_symbols() end, { desc = "LSP Symbols" })
vim.keymap.set(
  "n",
  "<leader>sS",
  function() Snacks.picker.lsp_workspace_symbols() end,
  { desc = "LSP Workspace Symbols" }
)
