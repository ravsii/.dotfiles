return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = { ensure_installed = { "rust" } },
  },
  {
    "mason-org/mason-lspconfig.nvim",
    opts = {
      ensure_installed = { "rust_analyzer" },
      -- We install it, just don't setup automatically
      -- Since rustaceanvim does that for us
      automatic_enable = { exclude = { "rust_analyzer" } },
    },
  },
  {
    "Saecki/crates.nvim",
    ft = "toml",
    event = { "BufRead Cargo.toml" },
    opts = {
      completion = {
        crates = {
          enabled = true,
        },
      },
      lsp = {
        enabled = true,
        actions = true,
        completion = true,
        hover = true,
      },
    },
  },
  {
    "mrcjkb/rustaceanvim",
    version = "^6", -- Recommended
    ft = { "rust" },
    lazy = false, -- This plugin is already lazy
  },
  {
    "nvim-neotest/neotest",
    optional = true,
    opts = {
      adapters = {
        ["rustaceanvim.neotest"] = {},
      },
    },
  },
}
