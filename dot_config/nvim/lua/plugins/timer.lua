local pomodoro_25_5 = function()
  local t = require("timers.timer")
  local d = require("timers.duration")
  local u = require("timers.unit")
  local m = require("timers.manager")

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
end

return {
  {
    "ravsii/timers.nvim",
    dir = "~/dev/OpenSource/timers.nvim/",
    dev = true,
    keys = {
      { "<leader>T", "", desc = "+timers" },
      { "<leader>Tp", pomodoro_25_5, desc = "Start Pomodoro 25/5 timer" },
      { "<leader>Ta", function() require("timers.ui").active_timers() end, desc = "Active timers" },
      { "<leader>Td", function() require("timers.ui.dashboard").show() end, desc = "Dashboard" },
      { "<leader>Tc", function() require("timers.ui").cancel() end, desc = "Cancel a timer" },
      { "<leader>TC", function() require("timers.ui").cancel_all() end, desc = "Cancel all timers" },
      { "<leader>Tn", function() require("timers.ui").create() end, desc = "Create a new timer" },
    },
    ---@module "timers.config"
    ---@type Config
    opts = {
      persistent = true,
      debug = false,
    },
    init = function()
      local aug = vim.api.nvim_create_augroup("TimerDevReload", { clear = true })
      vim.api.nvim_create_autocmd("BufWritePost", {
        group = aug,
        pattern = vim.fn.expand("~") .. "/dev/OpenSource/timer.nvim/**/*.lua",
        callback = function(args)
          local modname = args.file:match("timer.nvim/(.*)%.lua$")
          if modname then
            modname = modname:gsub("/", ".") -- convert path to module name
            package.loaded["timer"] = nil
          end
          vim.cmd("Lazy reload timer.nvim")
        end,
      })
    end,
  },
}
