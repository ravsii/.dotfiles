return {
  {
    "ravsii/timer.nvim",
    dir = "~/dev/OpenSource/timer.nvim/",
    dev = true,
    keys = {
      { "<leader>T", "", desc = "+timers" },
      {
        "<leader>Tp",
        function()
          local t = require("timer.timer")
          local d = require("timer.duration")
          local u = require("timer.unit")
          local m = require("timer")

          local break_duration = d.from(5 * u.MINUTE)
          local break_timer = t.new(break_duration, {
            message = "Break is over",
            title = "Break",
            log_level = vim.log.levels.WARN,
            icon = "⏾",
          })

          local ppomodoro_duration = d.from(25 * u.MINUTE)
          local pomodoro_timer = t.new(ppomodoro_duration, {
            title = "Pomodoro",
            message = "Pomodoro is over",
            icon = "",
            on_finish = function() m.start_timer(break_timer) end,
          })

          m.start_timer(pomodoro_timer)
        end,
        desc = "Start Pomodoro 25/5 timer",
      },
    },
    ---@module "timer.config"
    ---@type Config
    opts = {
      persistent = true,
    },
    init = function()
      local aug = vim.api.nvim_create_augroup("TimerDevReload", { clear = true })
      vim.api.nvim_create_autocmd("BufWritePost", {
        group = aug,
        pattern = vim.fn.expand("~") .. "/dev/OpenSource/timer.nvim/**/*.lua",
        callback = function() vim.cmd("Lazy reload timer.nvim") end,
      })
    end,
  },
}
