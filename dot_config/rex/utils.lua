local constants = require("constants")
local terminal = "com.superlogical.terminal"

local M = {}

--- @param ctx rex.Context
function M.cwd(ctx)
  local pwd = rex.block.call(terminal, "pwd", { block_id = ctx.block_id })
  if pwd and pwd.pwd then
    return (pwd.pwd:gsub("^file://[^/]*", ""))
  end
  local proc = rex.block.call(terminal, "process", { block_id = ctx.block_id })
  return proc and proc.foreground and proc.foreground.cwd
end

---@param command? string[] Program and its arguments.
---@return string[] shell_command Shell and its arguments.
local function shell_command(command)
  local full_command = { constants.shell, command and "-lic" or "-li" }
  if command then
    for _, arg in ipairs(command) do
      table.insert(full_command, arg)
    end
  end
  return full_command
end

function M.create_float(window_id, cwd, command)
  local layer, err = rex.session.new_layer({
    window_id = window_id,
    bounds = { 0.05, 0.05, 0.9, 0.9 },
    focus = true,
    layout = rex.layout.block({
      flavor = terminal .. ".shell",
      options = { cwd = cwd, command = shell_command(command), shell = constants.shell },
    }),
  })
  if err ~= nil then
    error(err, 0)
  end
  return layer
end

---@param cwd string
---@param command? string[] Program and its arguments.
---@return table session
function M.create_session(cwd, command)
  local session, err = rex.call("session.create", {
    initial_windows = {
      {
        layout = rex.layout.block({
          flavor = terminal .. ".shell",
          options = { cwd = cwd, command = shell_command(command), shell = constants.shell },
        }),
      },
    },
  })
  if not session then
    error(err, 0)
  end
  return session
end

return M
