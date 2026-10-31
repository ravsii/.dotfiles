vim.pack.add({
  "https://github.com/mfussenegger/nvim-dap",
  "https://github.com/igorlfs/nvim-dap-view",
  "https://github.com/ravsii/nvim-dap-envfile",
  "https://github.com/leoluz/nvim-dap-go",
  "https://github.com/jay-babu/mason-nvim-dap.nvim",
  "https://github.com/jbyuki/one-small-step-for-vimkind",
})

local dap = require("dap")

-- Mason
-- Установка Delve задана в lsp.lua; адаптеры настраиваем ниже.
require("mason-nvim-dap").setup({ automatic_installation = false })

-- Go
require("dap-go").setup()

-- Lua
dap.adapters.nlua = function(callback, config)
  callback({
    type = "server",
    host = config.host or "127.0.0.1",
    port = config.port or 8086,
  })
end

dap.configurations.lua = {
  {
    type = "nlua",
    request = "attach",
    name = "Attach to running Neovim instance",
    host = function() return "127.0.0.1" end,
    port = function() return 8086 end,
  },
}

-- Используем только Lua-конфигурации отладки, без .vscode/launch.json.
dap.providers.configs["dap.launch.json"] = nil

-- envFile
require("nvim-dap-envfile").setup({})

-- DAP View
require("dap-view").setup({
  winbar = {
    show = true,
    sections = { "repl", "scopes", "breakpoints", "exceptions", "threads", "watches", "console" },
    show_keymap_hints = true,
    default_section = "repl",
    controls = { enabled = true, position = "left" },
  },
  windows = {
    size = 0.3,
    position = "below",
    terminal = { size = 0.5, position = "right" },
  },
  auto_toggle = true,
  render = { sort_variables = function(lhs, rhs) return lhs.name < rhs.name end },
  icons = { collapsed = " ", expanded = " " },
})

-- Знаки
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

-- Аргументы запуска
local function get_args(config)
  local args = type(config.args) == "function" and (config.args() or {}) or config.args or {}
  local args_str = type(args) == "table" and table.concat(args, " ") or args
  config = vim.deepcopy(config)
  config.args = function()
    local new_args = vim.fn.expand(vim.fn.input("Run with args: ", args_str))
    return require("dap.utils").splitstr(new_args)
  end
  return config
end

-- Бинды
vim.keymap.set("n", "<leader>dB", function() dap.set_breakpoint(vim.fn.input("Breakpoint condition: ")) end, { desc = "Conditional breakpoint" })
vim.keymap.set("n", "<leader>dC", function() dap.run_to_cursor() end, { desc = "Run to Cursor" })
vim.keymap.set("n", "<leader>dO", function() dap.step_over() end, { desc = "Step Over" })
vim.keymap.set("n", "<leader>dP", function() dap.pause() end, { desc = "Pause" })
vim.keymap.set("n", "<leader>da", function() dap.continue({ before = get_args }) end, { desc = "Run with Args" })
vim.keymap.set("n", "<leader>db", function() dap.toggle_breakpoint() end, { desc = "Toggle Breakpoint" })
vim.keymap.set("n", "<leader>dc", function() dap.continue() end, { desc = "Run/Continue" })
vim.keymap.set("n", "<leader>dg", function() dap.goto_() end, { desc = "Go to Line (No Execute)" })
vim.keymap.set("n", "<leader>di", function() dap.step_into() end, { desc = "Step Into" })
vim.keymap.set("n", "<leader>dj", function() dap.down() end, { desc = "Down" })
vim.keymap.set("n", "<leader>dk", function() dap.up() end, { desc = "Up" })
vim.keymap.set("n", "<leader>dl", function() dap.run_last() end, { desc = "Run Last" })
vim.keymap.set("n", "<leader>do", function() dap.step_out() end, { desc = "Step Out" })
vim.keymap.set("n", "<leader>dr", function() dap.repl.toggle() end, { desc = "Toggle REPL" })
vim.keymap.set("n", "<leader>ds", function() dap.session() end, { desc = "Session" })
vim.keymap.set("n", "<leader>dt", function() dap.terminate() end, { desc = "Terminate" })
vim.keymap.set("n", "<leader>dw", function() require("dap.ui.widgets").hover() end, { desc = "Widgets" })

-- F-клавиши
vim.keymap.set("n", "<F3>", function() dap.toggle_breakpoint() end, { desc = "Toggle Breakpoint" })
vim.keymap.set("n", "<S-F3>", function() dap.set_breakpoint(vim.fn.input("Breakpoint condition: ")) end, { desc = "Conditional breakpoint" })
vim.keymap.set("n", "<F4>", function() dap.run_to_cursor() end, { desc = "Run to Cursor" })
vim.keymap.set("n", "<F5>", function() dap.step_over() end, { desc = "Step Over" })
vim.keymap.set("n", "<F7>", function() dap.step_into() end, { desc = "Step Into" })
vim.keymap.set("n", "<F9>", function() dap.step_out() end, { desc = "Step Out" })

-- DAP View
vim.keymap.set("n", "<leader>du", function() require("dap-view").toggle() end, { desc = "DAP View: Toggle Views" })
vim.keymap.set("n", "<leader>dE", function() require("dap-view").add_expr() end, { desc = "DAP View: Add Expression" })

-- Lua
vim.keymap.set("n", "<leader>dn", function() require("osv").launch({ port = 8086 }) end, { desc = "Neovim osv enable" })

-- Тесты
vim.keymap.set("n", "<leader>td", function()
  require("neotest").run.run({ strategy = "dap" })
end, { desc = "Debug Nearest" })
