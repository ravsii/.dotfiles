---@param config {type?:string, args?:string[]|fun():string[]?}
local function get_args(config)
  local args = type(config.args) == "function" and (config.args() or {}) or config.args or {} --[[@as string[] | string ]]
  local args_str = type(args) == "table" and table.concat(args, " ") or args --[[@as string]]

  config = vim.deepcopy(config)
  ---@cast args string[]
  config.args = function()
    local new_args = vim.fn.expand(vim.fn.input("Run with args: ", args_str)) --[[@as string]]
    return require("dap.utils").splitstr(new_args)
  end
  return config
end

return {
  {
    "jay-babu/mason-nvim-dap.nvim",
    dependencies = "mason.nvim",
    cmd = { "DapInstall", "DapUninstall" },
    opts = { automatic_installation = true },
    config = function() end,
  },
  {
    "mfussenegger/nvim-dap",
    -- stylua: ignore
    keys = {
      { "<leader>dB", function() require("dap").set_breakpoint(vim.fn.input('Breakpoint condition: ')) end, desc = "Breakpoint Condition" },
      { "<leader>dC", function() require("dap").run_to_cursor() end, desc = "Run to Cursor" },
      { "<leader>dO", function() require("dap").step_over() end, desc = "Step Over" },
      { "<leader>dP", function() require("dap").pause() end, desc = "Pause" },
      { "<leader>da", function() require("dap").continue({ before = get_args }) end, desc = "Run with Args" },
      { "<leader>db", function() require("dap").toggle_breakpoint() end, desc = "Toggle Breakpoint" },
      { "<leader>dc", function() require("dap").continue() end, desc = "Run/Continue" },
      { "<leader>dg", function() require("dap").goto_() end, desc = "Go to Line (No Execute)" },
      { "<leader>di", function() require("dap").step_into() end, desc = "Step Into" },
      { "<leader>dj", function() require("dap").down() end, desc = "Down" },
      { "<leader>dk", function() require("dap").up() end, desc = "Up" },
      { "<leader>dl", function() require("dap").run_last() end, desc = "Run Last" },
      { "<leader>do", function() require("dap").step_out() end, desc = "Step Out" },
      { "<leader>dr", function() require("dap").repl.toggle() end, desc = "Toggle REPL" },
      { "<leader>ds", function() require("dap").session() end, desc = "Session" },
      { "<leader>dt", function() require("dap").terminate() end, desc = "Terminate" },
      { "<leader>dw", function() require("dap.ui.widgets").hover() end, desc = "Widgets" },

      -- F keybinds
      { "<F3>", function() require("dap").toggle_breakpoint() end, desc = "Toggle Breakpoint" },
      { "<S-F3>", function() require("dap").set_breakpoint(vim.fn.input('Breakpoint condition: ')) end, desc = "Breakpoint Condition" },
      { "<F4>", function() require("dap").run_to_cursor() end, desc = "Run to Cursor" },
      { "<F5>", function() require("dap").step_over() end, desc = "Step Over" },
      { "<F7>", function() require("dap").step_into() end, desc = "Step Into" },
      { "<F9>", function() require("dap").step_out() end, desc = "Step Out" },
    },

    config = function()
      vim.api.nvim_set_hl(0, "DapStoppedLine", { default = true, link = "Visual" })

      local icons = {
        Stopped = { "󰁕 ", "DiagnosticWarn", "DapStoppedLine" },
        Breakpoint = " ",
        BreakpointCondition = " ",
        BreakpointRejected = { " ", "DiagnosticError" },
        LogPoint = ".>",
      }

      for name, sign in pairs(icons) do
        sign = type(sign) == "table" and sign or { sign }
        vim.fn.sign_define(
          "Dap" .. name,
          { text = sign[1], texthl = sign[2] or "DiagnosticInfo", linehl = sign[3], numhl = sign[3] }
        )
      end

      -- setup dap config by VsCode launch.json file
      local vscode = require("dap.ext.vscode")
      local json = require("plenary.json")
      vscode.json_decode = function(str)
        return vim.json.decode(json.json_strip_comments(str))
      end
    end,
  },
  -- Modern, minimalistic dapui
  {
    "igorlfs/nvim-dap-view",
    dependencies = { "mfussenegger/nvim-dap" },
    -- stylua: ignore
    keys = {
      { "<leader>du", function() require("dap-view").toggle() end, desc = "DAP View: Toggle Views" },
      { "<leader>dE", function() require("dap-view").add_expr() end, desc = "DAP View: Add Expression" },
    },
    ---@module 'dap-view'
    ---@type dapview.Config
    opts = {
      winbar = {
        show = true,
        sections = { "repl", "scopes", "breakpoints", "exceptions", "threads", "watches" },
        default_section = "scopes",
        base_sections = {
          breakpoints = { label = "[B]reakpoints" },
          exceptions = { label = "[E]xceptions" },
          watches = { label = "[W]atches" },
          threads = { label = "[T]hreads" },
          repl = { label = "[R]EPL" },
          console = { label = "[C]onsole" },
          scopes = { label = "Variable[S]" },
        },
        controls = { enabled = true, position = "left" },
      },
      windows = {
        height = 0.3,
        position = "below",
        terminal = {
          width = 0.5,
          position = "right",
          start_hidden = false,
        },
      },
      auto_toggle = true,
    },
    config = function(_, opts)
      local dap = require("dap")
      local dapview = require("dap-view")
      dapview.setup(opts)
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapview.open()
      end

      -- FIXME: if you'd like to close dap on exit.
      -- dap.listeners.before.event_terminated["dapui_config"] = function()
      --   dapui.close({})
      -- end
      -- dap.listeners.before.event_exited["dapui_config"] = function()
      --   dapui.close({})
      -- end
    end,
  },

  -- Usual DapUI, for those who interested.
  -- {
  --   "rcarriga/nvim-dap-ui",
  --   dependencies = { "nvim-neotest/nvim-nio" },
  --   -- stylua: ignore
  --   keys = {
  --     { "<leader>du", function() require("dapui").toggle({ }) end, desc = "Dap UI" },
  --     { "<leader>de", function() require("dapui").eval() end, desc = "Eval", mode = {"n", "v"} },
  --   },
  --   opts = {},
  --   config = function(_, opts)
  --     local dap = require("dap")
  --     local dapui = require("dapui")
  --     dapui.setup(opts)
  --     dap.listeners.after.event_initialized["dapui_config"] = function()
  --       dapui.open({})
  --     end
  --
  --     -- FIXME: if you'd like to close dap on exit.
  --     -- dap.listeners.before.event_terminated["dapui_config"] = function()
  --     --   dapui.close({})
  --     -- end
  --     -- dap.listeners.before.event_exited["dapui_config"] = function()
  --     --   dapui.close({})
  --     -- end
  --   end,
  -- },
}
