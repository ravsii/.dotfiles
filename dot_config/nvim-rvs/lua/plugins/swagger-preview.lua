return {
  "vinnymeller/swagger-preview.nvim",
  lazy = true,
  cmd = { "SwaggerPreview", "SwaggerPreviewStop", "SwaggerPreviewToggle" },
  build = "npm i",
  keys = {
    { "<leader>cP", "<cmd>SwaggerPreview<cr>", desc = "Toggle Swagger Preview" },
  },
  opts = {
    port = 6969,
    host = "127.0.0.1",
  },
}
