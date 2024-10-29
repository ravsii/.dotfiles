return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPost", "BufNewFile" },
  cmd = { "LspInfo", "LspInstall", "LspUninstall" },
  dependencies = {
    "mason.nvim",
    { "williamboman/mason-lspconfig.nvim", config = function() end },
  },
}
