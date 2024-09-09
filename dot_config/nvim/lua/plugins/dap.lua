return {
  {
    "rcarriga/nvim-dap-ui",
    opts = {
      layouts = {
        {
          elements = {
            {
              id = "repl",
              size = 1,
            },
          },
          position = "bottom",
          size = 20,
        },
        {
          elements = {
            {
              id = "scopes",
              size = 0.8,
            },
            {
              id = "breakpoints",
              size = 0.2,
            },
          },
          position = "left",
          size = 40,
        },
      },
      mappings = {
        edit = "e",
        expand = { "<CR>", "<LeftMouse>" },
        open = "o",
        remove = "d",
        repl = "r",
        toggle = "t",
      },
    },
  },
}
