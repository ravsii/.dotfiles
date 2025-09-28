return {
  {
    "shortcuts/no-neck-pain.nvim",
    version = "*",
    keys = {
      { "<leader>un", "<cmd>NoNeckPain<cr>", desc = "No Neck Pain" },
    },
    opts = {
      width = 80,
      buffers = {
        colors = {
          blend = -0.2,
        },
      },
    },
  },
}
