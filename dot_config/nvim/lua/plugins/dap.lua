return {
  {
    "rcarriga/nvim-dap-ui",
    opts = {
      layouts = {
        {
          elements = {
            {
              id = "scopes",
              size = 0.7,
            },
            {
              id = "breakpoints",
              size = 0.1,
            },
            {
              id = "stacks",
              size = 0.1,
            },
            {
              id = "watches",
              size = 0.1,
            },
          },
          position = "left",
          size = 50,
        },
        {
          elements = {
            {
              id = "repl",
              size = 0.9,
            },
            {
              id = "console",
              size = 0.1,
            },
          },
          position = "bottom",
          size = 10,
        },
      },
    },
  },
}
