return {
  {
    "michaelrommel/nvim-silicon",
    lazy = true,
    cmd = "Silicon",
    main = "nvim-silicon",
    keys = {
      { "<leader>S", mode = "v", group = "Silicon" },
      {
        "<leader>Sc",
        function()
          require("nvim-silicon").clip()
        end,
        mode = "v",
        desc = "Copy code screenshot to clipboard",
      },
      {
        "<leader>Sf",
        function()
          require("nvim-silicon").file()
        end,
        mode = "v",
        desc = "Save code screenshot as file",
      },
      {
        "<leader>Ss",
        function()
          require("nvim-silicon").shoot()
        end,
        mode = "v",
        desc = "Create code screenshot",
      },
    },
    -- https://github.com/michaelrommel/nvim-silicon?tab=readme-ov-file#setup
    opts = {},
  },
}
