return {
  {
    "rcarriga/nvim-dap-ui",
    opts = {
      layouts = {
        {
          elements = {
            {
              id = "scopes",
              size = 0.6,
            },
            {
              id = "breakpoints",
              size = 0.3,
            },
            {
              id = "watches",
              size = 0.1,
            },
            {
              id = "stacks",
              size = 0.1,
            },
          },
          position = "left",
          size = 60,
        },
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
      },
    },
  },
  {
    "mfussenegger/nvim-dap",

    -- stylua: ignore
    keys = {
      { "<F3>", function() require("dap").toggle_breakpoint() end, desc = "Toggle Breakpoint" },
      { "<S-F3>", function() require("dap").set_breakpoint(vim.fn.input('Breakpoint condition: ')) end, desc = "Breakpoint Condition" },
      { "<F4>", function() require("dap").run_to_cursor() end, desc = "Run to Cursor" },
      { "<F7>", function() require("dap").step_into() end, desc = "Step Into" },
      { "<F5>", function() require("dap").step_over() end, desc = "Step Over" },
      { "<F9>", function() require("dap").step_out() end, desc = "Step Out" },
    },
  },
}
