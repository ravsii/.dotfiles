return {
  {
    "nvim-neotest/neotest",
    dependencies = { "nvim-neotest/nvim-nio" },
    opts = {
      adapters = {},
      status = { virtual_text = true },
      output = { open_on_run = false },
      quickfix = { open = false },
    },
    config = function(_, opts)
      if opts.adapters then
        local adapters = {}
        for name, config in pairs(opts.adapters or {}) do
          if type(name) == "number" then
            if type(config) == "string" then
              config = require(config)
            end
            adapters[#adapters + 1] = config
          elseif config ~= false then
            local adapter = require(name)
            if type(config) == "table" and not vim.tbl_isempty(config) then
              local meta = getmetatable(adapter)
              if adapter.setup then
                adapter.setup(config)
              elseif adapter.adapter then
                adapter.adapter(config)
                adapter = adapter.adapter
              elseif meta and meta.__call then
                adapter = adapter(config)
              else
                error("Adapter " .. name .. " does not support setup")
              end
            end
            adapters[#adapters + 1] = adapter
          end
        end
        opts.adapters = adapters
      end

      require("neotest").setup(opts)
    end,
    keys = {
      { "<leader>t", "", desc = "+test" },
      { "<leader>tt", function() require("neotest").run.run(vim.fn.expand("%")) end, desc = "Run File (Neotest)" },
      { "<leader>tT", function() require("neotest").run.run(vim.uv.cwd()) end, desc = "Run All Test Files (Neotest)" },
      { "<leader>tr", function() require("neotest").run.run() end, desc = "Run Nearest (Neotest)" },
      { "<leader>tl", function() require("neotest").run.run_last() end, desc = "Run Last (Neotest)" },
      { "<leader>ts", function() require("neotest").summary.toggle() end, desc = "Toggle Summary (Neotest)" },
      {
        "<leader>to",
        function() require("neotest").output.open({ enter = true, auto_close = true }) end,
        desc = "Show Output (Neotest)",
      },
      { "<leader>tO", function() require("neotest").output_panel.toggle() end, desc = "Toggle Output Panel (Neotest)" },
      { "<leader>tS", function() require("neotest").run.stop() end, desc = "Stop (Neotest)" },
      {
        "<leader>tw",
        function() require("neotest").watch.toggle(vim.fn.expand("%")) end,
        desc = "Toggle Watch (Neotest)",
      },
    },
  },
  {
    "mfussenegger/nvim-dap",
    optional = true,
    keys = {
      { "<leader>td", function() require("neotest").run.run({ strategy = "dap" }) end, desc = "Debug Nearest" },
    },
  },
  {
    "andythigpen/nvim-coverage",
    dependencies = { "nvim-lua/plenary.nvim" },
    version = "*",
    keys = {
      { "<leader>tc", "<nop>", desc = "+coverage" },
      { "<leader>tcc", ":Coverage<cr>", desc = "Show coverage (input path)" },
      {
        "<leader>tcC",
        function()
          local path = vim.fn.input("Enter coverage path: ")
          if path ~= "" then
            vim.cmd("Coverage " .. path)
          else
            vim.cmd("Coverage")
          end
        end,
        desc = "Show coverage (input path)",
      },
      { "<leader>tcs", ":CoverageShow<CR>", desc = "Show coverage signs" },
      { "<leader>tch", ":CoverageHide<CR>", desc = "Hide coverage signs" },
      { "<leader>tct", ":CoverageToggle<CR>", desc = "Toggle coverage signs" },
      { "<leader>tcd", ":CoverageClear<CR>", desc = "Delete coverage cache" },
      { "<leader>tcm", ":CoverageSummary<CR>", desc = "Coverage summary" },
    },
    opts = {
      auto_reload = true,
      signs = {
        covered = { text = "+" },
        uncovered = { text = "-" },
        partial = { text = "~" },
      },
    },
  },
}
